class KnownAs
  include Neo4j::ActiveRel

  from_class  :Grouop
  to_class    :GroupName
  type 'known_as'
end
