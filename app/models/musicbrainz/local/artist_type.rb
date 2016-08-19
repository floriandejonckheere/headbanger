module Musicbrainz
module Local
  class ArtistType < Base
    has_many :artists,
                    :foreign_key => :type
  end
end
end
