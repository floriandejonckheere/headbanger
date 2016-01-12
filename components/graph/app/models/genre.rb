class Genre
  include Neo4j::ActiveNode

  property :name,         :index => :exact

  validates :name,        :presence => true

  has_many :in,   :supergenres, :origin => :genre
  has_many :out,  :subgenres,   :origin => :genre
end
