module Graph
  ##
  # Persistent entity which stores a model's data source keys
  #
  class RootNode
    include Neo4j::ActiveNode
    include Concerns::HasDataSource

    has_data_source :musicbrainz,   :index => true
    has_data_source :metal_archives
    has_data_source :discogs

    # Graph format version
    property :version,              :type => Integer,
                                    :default => Headbanger::GRAPH_VERSION

    validates :musicbrainz_key,
                  :presence => :true

    has_one :in,
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
