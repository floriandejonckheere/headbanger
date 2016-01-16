module Graph
  class KnownAs
    include Neo4j::ActiveRel
    property :preference,   :type => Float,     :default => 1

    validates :preference,
                  :presence => true
  end

  class ArtistKnownAs < KnownAs
    from_class  'Graph::Artist'
    to_class    'Graph::ArtistName'
    type :artist_known_as
  end

  class GroupKnownAs < KnownAs
    from_class  'Graph::Group'
    to_class    'Graph::GroupName'
    type :artist_known_as
  end
end
