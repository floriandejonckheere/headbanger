module Graph
  class Artist
    include Neo4j::ActiveNode
    include Virtualizable

    property :date_of_birth,  :type => Date

    virtualize :date_of_birth
    priority :musicbrainz => :very_high

    has_many :out,
                  :artist_names,
                  :type => :artist_known_as,
                  :model_class => 'Graph::ArtistName',
                  :dependent => :destroy

    has_many :out,
                  :groups,
                  :type => :member_of,
                  :model_class => 'Graph::Group'

    has_many :out,
                  :data_sources,
                  :type => :described_by,
                  :model_class => 'Graph::DataSource'
  end

  class HeavyMetalArtist < Artist
    include Virtualizable

    priority :metal_archives => :very_high,
              :musicbrainz => :high
  end
end
