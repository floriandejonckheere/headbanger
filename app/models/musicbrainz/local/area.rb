module Musicbrainz
module Local
  class Area < Base
    has_many :artists,
                    :foreign_key => :area

    belongs_to :area_type,
                    :foreign_key => :type,
                    :optional => true
  end
end
end
