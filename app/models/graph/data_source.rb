module Graph
  class DataSource
    include Neo4j::ActiveNode

    property :type,            :contraint => :unique

    has_many :in,
                  :models,
                  :type => :described_by,
                  :model_class => Graph::DescribedBy.from_class
  end
end
