module Graph
  class BasedIn
    include Neo4j::ActiveRel

    from_class  'Graph::Group'
    to_class    'Graph::Country'
    type :based_in
  end
end
