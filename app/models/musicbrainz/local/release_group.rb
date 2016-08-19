module Musicbrainz
module Local
  class ReleaseGroup < Base
    alias_attribute :mbid, :gid

    has_artist_credits
    has_mbid

    def to_param
      self.mbid
    end
  end
end
end
