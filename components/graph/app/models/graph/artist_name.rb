module Graph
  class ArtistName
    include Neo4j::ActiveNode

    property :name,       :index => :exact

    validates :name,
                  :presence => true

    has_one :in,
                :artist,
                :model_class => :Artist,
                :rel_class => :alias_of
  end
end
