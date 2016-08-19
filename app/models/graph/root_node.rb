module Graph

  ##
  # Persistent entity which stores a model's data source keys
  #
  class RootNode
    include Neo4J::ActiveNode

    property :musicbrainz_key,      :index => :exact
    property :metal_archives_key
    property :discogs_key

    # TODO: change to Integer for performance reasons
    property :timestamp,            :type => DateTime

    # Node format version
    property :version,              :type => Integer,
                                    :default => Headbanger::NODE_VERSION

    validates :musicbrainz_key,
                  :presence => :true

    has_many :in,
                  :model,
                  :type => :described_by,
                  :model_class => [
                                    'Graph::Artist',
                                    'Graph::Group',
                                    'Graph::Release',
                                    'Graph::Label'
                                  ]
  end
end
