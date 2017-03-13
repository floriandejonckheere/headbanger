module Graph
  ##
  # A lyrical theme
  #
  class LyricalTheme
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
  end
end
