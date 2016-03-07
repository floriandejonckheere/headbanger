module Graph
  class AppearsIn
    include Neo4j::ActiveRel

    from_class  [
                  'Graph::Artist',
                  'Graph::Group'
                ]
    to_class    'Graph::Release'
    type :appears_in

    property :role
  end
end
