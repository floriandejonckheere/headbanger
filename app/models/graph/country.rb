module Graph
  ##
  # A country
  #
  class Country
    include Neo4j::ActiveNode

    property :country,
                      :type => ISO3166::Country


    validates :country,
                      :presence => true

    has_many :out,
                :performers,
                :type => :based_in,
                :model_class => [
                                  'Graph::Artist',
                                  'Graph::Group'
                                ],
                :unique => { :on => :musicbrainz_key }
  end
end
