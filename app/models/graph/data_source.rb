require Rails.root.join 'lib', 'neo4j', 'symbol_converter'

module Graph
  class DataSource
    include Neo4j::ActiveNode

    property :type,            :type => Symbol, :contraint => :unique

    has_many :in,
                  :models,
                  :type => :described_by,
                  :model_class => DescribedBy.from_class

    def controller
      "DataSources::#{self.type.camelize}Controller".constantize
    end
  end
end
