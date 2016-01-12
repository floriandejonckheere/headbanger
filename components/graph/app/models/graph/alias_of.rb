module Graph
  class AliasOf
    include Neo4j::ActiveRel

    from_class  :Artist
    to_class    :ArtistName
    type 'alias_of'
  end
end
