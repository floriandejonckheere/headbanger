module Graph
  ##
  # A group of performers
  #
  class Group
    include Neo4j::ActiveNode
    include Graph::DataNode

    # Properties
    property :year_formed,
                          :type => Date
    property :description

    enum :status => [:active, :split_up, :on_hold, :changed_name, :disputed, :unknown]

    # Associations
    has_many :out,
                :names,
                :type => :known_as,
                :model_class => 'Graph::Name',
                :dependent => :destroy,
                :unique => true

    has_one :out,
              :country,
              :type => :based_in,
              :model_class => 'Graph::Country'

    has_many :in,
                :artists,
                :type => :member_of,
                :model_class => 'Graph::Artist',
                :unique => true

    has_many :out,
                :lyrical_themes,
                :type => :sings_about,
                :model_class => 'Graph::LyricalTheme',
                :unique => true

    has_many :out,
                :genres,
                :type => :plays_genre,
                :model_class => 'Graph::Genre',
                :unique => true

    has_many :out,
                :releases,
                :type => :has_released,
                :model_class => 'Graph::Release',
                :unique => true
  end
end
