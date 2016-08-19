module Musicbrainz
module Local
  class Gender < Base
    has_many :artists,
                    :foreign_key => :gender
  end
end
end
