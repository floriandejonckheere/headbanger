module Musicbrainz
module Local
  class ArtistAlias < Base
    belongs_to :artist,
                    :foreign_key => :artist,
                    :optional => true
  end
end
end
