module Graph
  ##
  # Relation that indicates an artist contributing in a group
  #
  class MemberOf
    include Neo4j::ActiveRel

    from_class  'Graph::Artist'
    to_class    'Graph::Group'
    type :member_of

    property :start_date,   :type => Date
    property :end_date,     :type => Date
  end
end
