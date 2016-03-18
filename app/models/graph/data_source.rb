require Rails.root.join 'lib', 'neo4j', 'symbol_converter'

module Graph
  class DataSource
    include Neo4j::ActiveNode

    property :type,            :type => Symbol, :contraint => :unique
    property :key

    # TODO: change to Integer for performance reasons
    property :timestamp,    :type => DateTime

    validates :key,
                  :presence => true

    has_many :in,
                  :model,
                  :type => :described_by,
                  :model_class => [
                                    'Graph::Artist'
                                  ]
  end
end
