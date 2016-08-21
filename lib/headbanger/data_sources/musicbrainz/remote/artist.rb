module Headbanger
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
              :name,
              :type,
              :release_groups,
              :to => :@object
  end
end
end
end
end
