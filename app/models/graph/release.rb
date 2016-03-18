module Graph
  class Release
    include Neo4j::ActiveNode

    property :title
    property :release_date,  :type => Date

    id_property :gid

    has_many :in,
                  :performers,
                  :type => :appears_in,
                  :model_class => [
                                    'Graph::Artist',
                                    'Graph::Group'
                                  ]

    has_many :out,
                  :data_sources,
                  :type => :described_by,
                  :model_class => 'Graph::DataSource',
                  :dependent => :destroy
  end
end
