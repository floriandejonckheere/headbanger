module DataSources
module Musicbrainz
module Remote
  class Artist
    attr_accessor :object

    def initialize(id)
      @object = MusicBrainz::Artist.find id
    end

    delegate :date_begin,
              :date_end,
              :to => :@object
  end
end
end
end
