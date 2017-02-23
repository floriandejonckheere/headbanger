require_relative '../errors'

module Headbanger
module Sisyphus
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
      logger.info { "[#{musicbrainz_key}] Starting update of #{self.class.graph_model}" }

      # Find or create instance of Graph::MyModel
      begin
        @instance = self.class.graph_model.find_by! :musicbrainz_key => musicbrainz_key
        logger.debug { "[#{musicbrainz_key}] Found instance of #{self.class.graph_model}" }
      rescue Neo4j::RecordNotFound
        logger.info { "[#{musicbrainz_key}] Creating #{self.class.graph_model}" }
        @instance = self.class.graph_model.new :musicbrainz_key => musicbrainz_key
      end

      # Update instances
      if @instance.updated_at? and (@instance.updated_at + VALID_FOR).future?
        logger.info { "[#{musicbrainz_key}] Up to date" }
      else
        logger.info { "[#{musicbrainz_key}] Out of date" }
        Neo4j::ActiveBase.run_transaction do |tx|
          begin
            logger.debug { "[#{musicbrainz_key}] Updating sources" }
            update_sources

            logger.debug { "[#{musicbrainz_key}] Updating instance" }
            update_instance
          rescue NotImplementedError => e
            # Print warning and ignore
            logger.warn { "[#{musicbrainz_key}] #{e}" }
          rescue => e
            logger.error { "[#{musicbrainz_key}] Failed to update" }
            logger.error { "[#{musicbrainz_key}] #{e}" }
            e.backtrace.each { |b| logger.warn { "[#{musicbrainz_key}] #{b}" } }

            # Fail transaction
            if e.is_a? PersistentError
              # Hard-fail transaction
              logger.error { "[#{musicbrainz_key}] Rolling back transaction" }
              tx.mark_failed
            else
              # TODO: Soft-fail transaction
              logger.error { "[#{musicbrainz_key}] Soft-failing transaction" }
            end
          end

          @instance.save
        end
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
