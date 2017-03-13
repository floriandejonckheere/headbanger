module Graph
  ##
  # A music genre
  #
  class Genre
    include Neo4j::ActiveNode

    # Attributes
    property :name
              # :unique => true

    validates :name,
                  :presence => true

    # Associations
    has_many :in,
             :groups,
             :type => :sings_about,
             :model_class => 'Graph::Group',
             :unique => true

    has_many :in,
                :subgenres,
                :type => :related_to,
                :model_class => 'Graph::Genre',
                :unique => { :on => :name }

    has_many :out,
                :supergenres,
                :type => :related_to,
                :model_class => 'Graph::Genre',
                :unique => { :on => :name}
  end
end
