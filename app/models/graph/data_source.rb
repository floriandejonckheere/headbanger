require Rails.root.join 'lib', 'neo4j', 'symbol_converter'

module Graph
  class DataSource
    include Neo4j::ActiveNode

    enum :type => [:musicbrainz, :metal_archives], _index: false
    property :key

    # TODO: change to Integer for performance reasons
    property :timestamp,    :type => DateTime

    validates :key,
                  :presence => true

    has_many :in,
                  :model,
                  :type => :described_by,
                  :model_class => [
                                    'Graph::Artist',
                                    'Graph::Group',
                                    'Graph::Release'
                                  ]
  end
end
