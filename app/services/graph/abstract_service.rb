module Graph
  ##
  # Headbanger data aggregation framework (single datanode)
  #
  class AbstractService
    include Sidekiq::Worker

    def initialize
      raise NotImplementedError, 'Cannot instantiate abstract class'
    end

    def perform(metal_archives_key)
      Neo4j::ActiveBase.run_transaction do |tx|
        begin
          @instance = model.find_or_initialize_by :metal_archives_key => metal_archives_key

          update_instance if @instance.stale?
        rescue => e
          logger.error e
          tx.mark_failed
        end
      end
    end

    ##
    # Returns lazy Enumerable collection over all objects
    #
    def enumerate; end

    protected

    ##
    # Returns Graph model constant
    #
    def model; end
  end
end
