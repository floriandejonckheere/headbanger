module Graph
  class City
    include Neo4j::ActiveNode

    property :name

    has_one :out,
                  :country,
                  :type => :located_in,
                  :model_class => 'Graph::Country'
  end
end
