class Musicbrainz::Gender < Musicbrainz::Base
  has_many :artists, :foreign_key => :gender
end
