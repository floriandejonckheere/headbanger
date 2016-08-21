module Graph
  ##
  # A release
  #
  class Release
    include Neo4j::ActiveNode
    include Concerns::Sourceable

    has_sources

    property :title
    property :release_date,
                          :type => Date

    has_many :in,
                :performers,
                :type => :appears_in,
                :model_class => [
                                  'Graph::Artist',
                                  'Graph::Group'
                                ]
  end
end
