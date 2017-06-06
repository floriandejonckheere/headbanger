# frozen_string_literal: true

module Graph
  ##
  # Headbanger data aggregation framework (single datanode)
  #
  class AbstractService
    include Sidekiq::Worker

    attr_accessor :instance

    ##
    # Add or update a graph node
    #
    def perform(metal_archives_key)
      raise Headbanger::NoKeyError unless metal_archives_key

      debug 'Starting update'
      instance = model.find_or_initialize_by :metal_archives_key => metal_archives_key

      debug 'Fresh instance' if instance.fresh?
      return if instance.fresh?

      Neo4j::ActiveBase.run_transaction do |tx|
        begin
          debug 'Stale instance'
          update_instance
        rescue => e
          tx.mark_failed
          raise e
        end
      end
    end

    protected

    ##
    # Returns lazy Enumerable collection over all objects
    #
    def enumerate; end

    ##
    # Returns Graph model constant
    #
    def model; end

    ##
    # Sanitize string
    #
    def sanitize(string)
      ActionView::Base.full_sanitizer.sanitize string
    end

    ##
    # Format log message
    #
    def format(msg)
      "[#{model}] [#{@instance&.metal_archives_key}] #{msg}"
    end

    %i[debug warn info error].each do |level|
      define_method(level.to_s) { |msg| logger.send level, format(msg) }
    end
  end
end
