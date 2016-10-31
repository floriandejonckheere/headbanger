require_relative '../errors'

module Headbanger
module Sisyphus
  class SisyphusWorker
    include Sidekiq::Worker

    attr_accessor :instance,
                  :musicbrainz,
                  :metal_archives

    def perform(musicbrainz_key)
      ## Find or create instance of Graph::MyModel
      begin
        @instance = model.find_by! :musicbrainz_key => musicbrainz_key
      rescue Neo4j::RecordNotFound
        logger.info { "[#{musicbrainz_key}] Creating #{model}" }
        @instance = model.new :musicbrainz_key => musicbrainz_key
      end

      ## Update instance
      update_sources
      begin
        transaction = Neo4j::Transaction.new

        begin
          update_instance
        rescue Headbanger::NotImplementedError => e
          # Print warning and ignore
          logger.warn { "[#{musicbrainz_key}] #{e}" }
          e.backtrace.each { |b| logger.warn { "[#{musicbrainz_key}] #{b}" } }
        end

        @instance.save!
      rescue => e
        logger.error { "[#{musicbrainz_key}] Failed to update #{model}" }
        logger.error { "[#{musicbrainz_key}] #{e}" }
        e.backtrace.each { |b| logger.error { "[#{musicbrainz_key}] #{b}" } }
        transaction.mark_failed
        raise e
      ensure
        transaction.close
      end
    end

    def update_attribute(attribute)
      @instance[attribute] = send attribute
    rescue => e
      logger.error { "[#{musicbrainz_key}] Failed to update #{model}.#{attribute}" }
      logger.error { "[#{musicbrainz_key}] #{e}" }
      e.backtrace.each { |b| logger.error { "[#{musicbrainz_key}] #{b}" } }
      raise e
    end

    def update_association(association)
      send association
    end

    def valid?(timestamp, valid_for)
      (timestamp.is_a? Date and (timestamp + valid_for).future?)
    end
  end
end
end
