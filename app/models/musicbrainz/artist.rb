class Musicbrainz::Artist < Musicbrainz::Base
  alias_attribute :mbid, :gid

  has_many :artist_aliases, :foreign_key => :artist

  belongs_to :artist_type, :foreign_key => :type, :optional => true
  belongs_to :area, :foreign_key => :area, :optional => true
  belongs_to :gender, :foreign_key => :gender, :optional => true

  has_many :artist_credit_name, :foreign_key => :artist
  has_many :artist_credits, :through => :artist_credit_name

  has_many :release_groups, :through => :artist_credits

  has_mbid

  def to_param
    self.mbid
  end
end
