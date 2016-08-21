module Musicbrainz
module Local
  class ArtistCreditName < Base
    belongs_to :artist,
                      :foreign_key => :artist,
                      :optional => true

    belongs_to :artist_credit,
                      :foreign_key => :artist_credit,
                      :optional => true
  end
end
end