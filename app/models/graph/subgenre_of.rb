module Graph
  class SubgenreOf
    include Neo4j::ActiveRel

    from_class  'Graph::Genre'
    to_class    'Graph::Genre'
    type :subgenre_of
  end
end
