module Graph
  class SingsAbout
    include Neo4j::ActiveRel

    from_class  'Graph::Group'
    to_class    'Graph::LyricalTheme'
    type :sings_about
  end
end
