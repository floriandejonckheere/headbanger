module Graph
  class Label
    include Neo4j::ActiveNode

    property :name

    has_one :out,
                  :root_node,
                  :type => :described_by,
                  :model_class => 'Graph::RootNode'
  end
end
