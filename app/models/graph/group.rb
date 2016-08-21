module Graph
  ##
  # A group of performers
  #
  class Group
    include Neo4j::ActiveNode
    include Concerns::Sourceable

    has_sources

    # ISO-3166-1 alpha 2 (e.g. US, BE)
    property :country
    property :year_formed,
                          :type => Date

    has_many :out,
                :names,
                :type => :known_as,
                :model_class => 'Graph::Name',
                :dependent => :destroy

    has_many :in,
                :artists,
                :type => :member_of,
                :model_class => 'Graph::Artist'

    has_many :out,
                :lyrical_themes,
                :type => :sings_about,
                :model_class => 'Graph::LyricalTheme'

    has_many :out,
                :releases,
                :type => :appears_in,
                :model_class => 'Graph::Release'
  end
end
