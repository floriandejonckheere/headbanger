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
        property :musicbrainz_key,            :index => :exact
        property :musicbrainz_timestamp,      :type => DateTime

        property :metal_archives_key
        property :metal_archives_timestamp,   :type => DateTime

        property :discogs_key
        property :discogs_timestamp,          :type => DateTime

        validates :musicbrainz_key,
                                  :presence => true

        # Graph schema version
        property :version,  :type => Integer,
                            :default => Headbanger::GRAPH_VERSION
        end
    end
  end
end
end
