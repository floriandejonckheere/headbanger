module Graph
  ##
  # A record label
  #
  class Label
    include Neo4j::ActiveNode
    include Concerns::Sourceable

    has_sources

    property :name,
                  :index => :exact
  end
end
