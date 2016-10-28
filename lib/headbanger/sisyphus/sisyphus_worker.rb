module Headbanger
module Sisyphus
  class SisyphusWorker
    include Sidekiq::Worker

    attr_accessor :model,
                  :instance,
                  :musicbrainz,
                  :metal_archives

    ##
    # Declare Graph model
    #
    def self.model(model_sym)
      @model_name = model_sym.to_s
    end

    def perform(musicbrainz_key)
      model = Graph.const_get self.class.model_name.camelize

      ## Find or create instance of Graph::MyModel
      begin
        @instance = model.find_by! :musicbrainz_key => musicbrainz_key
      rescue Neo4j::RecordNotFound
        logger.info "Creating #{@model} with mbid #{musicbrainz_key}"
        @instance = model.new :musicbrainz_key => musicbrainz_key
      end

      ## Update instance
      update_sources
      begin
        transaction = Neo4j::Transaction.new

        update_instance
        @instance.save
      rescue Error => e
        logger.error "Failed to update #{@model} with mbid #{musicbrainz_key}: #{e}"
        transaction.mark_failed
      ensure
        transaction.close
      end
    end

    def update_attribute(attribute)
      @instance[attribute] = send attribute
    rescue Error => e
      logger.error "Failed to update #{@model}.#{attribute} with mbid #{musicbrainz_key}: #{e}"
      logger.error e
      logger.error e.backtrace.join '\n'
    end

    def update_association(association)
      send association
    end

    def logger
      Headbanger::Sisyphus.logger
    end

    def valid?(timestamp, valid_for)
      (timestamp.is_a? Date and (timestamp + valid_for).future?)
    end
  end
end
end
