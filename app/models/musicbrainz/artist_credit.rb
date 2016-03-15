class Musicbrainz::ArtistCredit < Musicbrainz::Base
  has_many :artist_credit_names, :foreign_key => :artist_credit
  has_many :artists, :through => :artist_credit_names

  has_many :release_groups, :foreign_key => :artist_credit
end
