module Graph
  class Genre
    include Neo4j::ActiveNode

    property :name,           :constraint => :unique

    validates :name,          :presence => true

    has_many :in,   :subgenres,   :origin => 'Graph::Genre'
    has_many :out,  :subgenres,   :origin => 'Graph::Genre'
  end
end
