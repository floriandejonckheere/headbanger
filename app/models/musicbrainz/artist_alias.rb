class Musicbrainz::ArtistAlias < Musicbrainz::Base
  belongs_to :artist, :foreign_key => :artist
end
