module Graph
  class Artist
    include Neo4j::ActiveNode

    property :gid,            :contraint => :unique
    property :date_of_birth,  :type => Date

    validates :gid,
                  :presence => true,
                  :format => { :with => /\A[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}\Z/ }

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
end
