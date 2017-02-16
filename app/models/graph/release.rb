module Graph
  ##
  # A release
  #
  class Release < DataNode
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
