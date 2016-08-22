module Headbanger
module DataSources
module Musicbrainz
  class Artist
    attr_accessor :object

    def initialize(id)
      @object = Musicbrainz::Artist.find id
    end
  end
end
end
end
