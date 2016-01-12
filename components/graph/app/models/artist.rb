class Artist
  include Neo4j::ActiveNode

  property :gid,            :index => :exact
  property :date_of_birth,  :type => Date

  validates :gid,
                :presence => true,
                :format => { :with => /\A[a-z0-0]{8}-[a-z0-0]{4}-[a-z0-0]{4}-[a-z0-0]{4}-[a-z0-0]{12}\Z/ }

  has_many :out,
                :artist_names,
                :model_class => :ArtistName,
                :rel_class => :alias_of,
                :dependent => :destroy
end
