module Graph
  class Country
    include Neo4j::ActiveNode

    # ISO-3166-1 alpha 2
    property :country_code,             :contraint => :unique

    has_one :in,
                  :groups,
                  :type => :based_in,
                  :model_class => 'Graph::Group'
  end
end
