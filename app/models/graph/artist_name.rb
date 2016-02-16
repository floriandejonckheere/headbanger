module Graph
  class ArtistName
    include Neo4j::ActiveNode

    property :name,       :index => :exact

    validates :name,
                  :presence => true,
                  :length => { :in => 3..64 }

    has_one :in,
                :artist,
                :type => :artist_known_as,
                :model_class => 'Graph::Artist'
  end
end
