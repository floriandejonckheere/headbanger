module Graph
  class Artist
    include Neo4j::ActiveNode

    property :date_of_birth,  :type => Date
    property :date_of_death,  :type => Date

    has_many :out,
                  :names,
                  :type => :known_as,
                  :model_class => 'Graph::Name',
                  :dependent => :destroy

    has_many :out,
                  :groups,
                  :type => :member_of,
                  :model_class => 'Graph::Group'

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
