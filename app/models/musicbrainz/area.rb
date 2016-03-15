class Musicbrainz::Area < Musicbrainz::Base
  has_many :artists, :foreign_key => :area

  belongs_to :area_type, :foreign_key => :type
end
