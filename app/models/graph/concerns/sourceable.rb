module Graph
module Concerns
  ##
  # Define data source fields
  #
  module Sourceable
    def self.included(base)
        base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_sources
        # Don't forget to use migrations to add an index on :musicbrainz_key when using this concern

        property :musicbrainz_key
        property :musicbrainz_timestamp,      :type => DateTime

        property :metal_archives_key
        property :metal_archives_timestamp,   :type => DateTime

        property :discogs_key
        property :discogs_timestamp,          :type => DateTime

        validates :musicbrainz_key,
                                  :presence => true
      end
    end
  end
end
end
