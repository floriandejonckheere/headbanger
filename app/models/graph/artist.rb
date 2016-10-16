module Graph
  ##
  # A single performer (but not a solo artist)
  #
  class Artist
    include Neo4j::ActiveNode
    include Concerns::Sourceable

    has_sources

    property :gender,
                    :type => String
    property :date_of_birth,
                          :type => Date
    property :date_of_death,
                          :type => Date
    property :biography,
                    :type => String

    has_one :out,
              :country,
              :type => :based_in,
              :model_class => 'Graph::Country'

    has_many :out,
                :names,
                :type => :known_as,
                :model_class => 'Graph::Name',
                :dependent => :destroy,
                :unique => true

    has_many :out,
                :groups,
                :type => :member_of,
                :model_class => 'Graph::Group',
                :unique => { :on => :musicbrainz_key }

    has_many :out,
                :releases,
                :type => :appears_in,
                :model_class => 'Graph::Release',
                :unique => { :on => :musicbrainz_key }
  end
end
