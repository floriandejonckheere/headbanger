module Graph
  class Group
    include Neo4j::ActiveNode

    # ISO-3166-1 alpha 2 (e.g. US, BE)
    property :country,        :index => :exact
    property :year_formed,    :type => Date

    id_property :gid

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

    has_many :out,
                  :data_sources,
                  :type => :described_by,
                  :model_class => 'Graph::DataSource'
  end
end
