class Musicbrainz::ReleaseGroup < Musicbrainz::Base
  alias_attribute :mbid, :gid

  has_artist_credits
  has_mbid

  def to_param
    self.mbid
  end
end
