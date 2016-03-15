class Musicbrainz::ArtistCreditName < Musicbrainz::Base
  belongs_to :artist, :foreign_key => :artist

  belongs_to :artist_credit, :foreign_key => :artist_credit
end
