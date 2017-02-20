module Headbanger
module Sisyphus
  ##
  # Framework for background information aggregation
  #
  class SisyphusWorker
    include Sidekiq::Worker

    VALID_FOR = 6.months

    class << self
      attr_accessor :graph_model

      ##
      # Define the graph model sym
      #
      def model(model_sym)
        @graph_model = Graph.const_get model_sym.to_s.camelize
      end
    end

    attr_accessor :instance,
                  :musicbrainz,
                  :metal_archives

    ##
    # Create or update a data node
    #
    def perform(musicbrainz_key)
      # Find or create instance of Graph::MyModel
      begin
        @instance = self.class.graph_model.find_by! :musicbrainz_key => musicbrainz_key
      rescue Neo4j::RecordNotFound
        logger.info { "[#{musicbrainz_key}] Creating #{self.class.graph_model}" }
        @instance = self.class.graph_model.new :musicbrainz_key => musicbrainz_key
      end

      # Update instances
      require 'byebug'; byebug
      unless @instance.updated_at? and (@instance.updated_at + VALID_FOR).future?
        update_sources

        Neo4j::Transaction.run do |tx|
          begin
            update_instance
          rescue NotImplementedError => e
            # Print warning and ignore
            logger.warn { "[#{musicbrainz_key}] #{e}" }
            e.backtrace.each { |b| logger.warn { "[#{musicbrainz_key}] #{b}" } }
          rescue => e
            logger.warn { "[#{musicbrainz_key}] #{e}" }
            logger.error { "[#{musicbrainz_key}] Failed to update #{self.class.graph_model}" }
            e.backtrace.each { |b| logger.warn { "[#{musicbrainz_key}] #{b}" } }

            # Fail transaction
            if e.is_a? PersistentError
              # Hard-fail transaction
              logger.error { "[#{musicbrainz_key}] Rolling back transaction" }
              tx.mark_failed
            else
              # TODO: Soft-fail transaction
            end
          end
        end
      else
        logger.info { "[#{musicbrainz_key}] #{self.class.graph_model} up to date" }
      end
    end

    ##
    # Update an attribute on @instance
    #
    def update_attribute(attribute)
      @instance[attribute] = send attribute
      do_handle_error(:attribute => attribute) { @instance[attribute] = send attribute }
    end

    def update_association(association)
      do_handle_error(:association => association) { send association }
    end

    ##
    # Contingency method error handling
    #
    def do_handle_error(hash = nil)
      yield
    rescue NotImplementedError => e
      logger.warn { "[#{@instance.musicbrainz_key}] #{e}" }
      e.backtrace.each { |b| logger.error { "[#{@instance.musicbrainz_key}] #{b}" } }
    rescue => e
      logger.error { "[#{@instance.musicbrainz_key}] Failed to update #{self.class.graph_model}" }
      logger.error { "[#{@instance.musicbrainz_key}] #{hash.to_s}"} if hash
      logger.error { "[#{@instance.musicbrainz_key}] #{e}" }
      e.backtrace.each { |b| logger.error { "[#{@instance.musicbrainz_key}] #{b}" } }
      raise e
    end

    ##
    # Overridable method; sets data sources when @instance is out of date
    #
    def update_sources; end

    ##
    # Overridable method; updates @instance
    def update_instance; end
  end
end
end
