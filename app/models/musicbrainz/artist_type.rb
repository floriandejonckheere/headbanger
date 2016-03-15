class Musicbrainz::ArtistType < Musicbrainz::Base
  has_many :artists, :foreign_key => :type
end
