module Graph
  ##
  # A music genre
  #
  class Genre
    include Neo4j::ActiveNode

    property :name,           :constraint => :unique

    validates :name,          :presence => true

    has_many :in,
                  :subgenres,
                  :type => :subgenre_of,
                  :model_class => 'Graph::Genre'

    has_many :out,
                  :supergenres,
                  :type => :subgenre_of,
                  :model_class => 'Graph::Genre'
  end
end
