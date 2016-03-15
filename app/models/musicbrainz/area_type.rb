class Musicbrainz::AreaType < Musicbrainz::Base
  has_many :areas, :foreign_key => :type
end
