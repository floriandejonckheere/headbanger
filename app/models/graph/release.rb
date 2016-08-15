module Graph
  class Release
    include Neo4j::ActiveNode

    property :title
    property :release_date,  :type => Date

    has_one :out,
                  :root_node,
                  :type => :described_by,
                  :model_class => 'Graph::RootNode'

    has_many :in,
                  :performers,
                  :type => :appears_in,
                  :model_class => [
                                    'Graph::Artist',
                                    'Graph::Group'
                                  ]
  end
end
