module Graph
  ##
  # A release
  #
  class Release
    include Neo4j::ActiveNode

    # Data sources
    property :musicbrainz_key
    property :metal_archives_key

    property :updated_at,
                        :type => DateTime

    # Attributes
    property :title
    property :release_date,
                          :type => Date

    # Associations
    has_many :in,
                :performers,
                :type => :appears_in,
                :model_class => [
                                  'Graph::Artist',
                                  'Graph::Group'
                                ],
                :unique => { :on => :musicbrainz_key }

    has_many :in,
               :groups,
               :type => :appears_in,
               :model_class => 'Graph::Group',
               :unique => true

    has_many :in,
               :artists,
               :type => :appears_in,
               :model_class => 'Graph::Artist',
               :unique => true
  end
end
