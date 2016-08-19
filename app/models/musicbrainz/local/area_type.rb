module Musicbrainz
module Local
  class AreaType < Base
    has_many :areas,
                  :foreign_key => :type
  end
end
end
