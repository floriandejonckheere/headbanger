module Graph
  ##
  # A record label
  #
  class Label
    include Neo4j::ActiveNode
    include Concerns::HasRootNode

    has_root_node

    property :name
  end
end
