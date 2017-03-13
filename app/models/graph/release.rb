module Graph
  ##
  # A release
  #
  class Release
    include Neo4j::ActiveNode
    include Graph::DataNode

    # Attributes
    property :title
    property :release_date,
                          :type => Date

    # Associations
    has_many :in,
               :groups,
               :type => :has_released,
               :model_class => 'Graph::Group',
               :unique => { :on => :musicbrainz_key }

    has_many :in,
               :artists,
               :type => :appears_in,
               :model_class => 'Graph::Artist',
               :unique => { :on => :musicbrainz_key }
  end
end
