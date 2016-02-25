module Graph
  class DataSource
    include Neo4j::ActiveNode

    property :type,            :contraint => :unique

    has_many :in,
                  :models,
                  :type => :described_by,
                  :model_class => Graph::DescribedBy.from_class

    def controller
      "DataSources::#{self.type.camelize}Controller".constantize
    end
  end
end
