module Graph
  class KnownAs
    include Neo4j::ActiveRel

    from_class  :Group
    to_class    :GroupName
    type 'known_as'
  end
end
