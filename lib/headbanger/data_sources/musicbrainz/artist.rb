module Headbanger
module DataSources
module Musicbrainz
  ##
  # Mapping layer for Artist onto Musicbrainz database
  #
  class Artist
    attr_accessor :object

    def initialize(mbid)
      @object = ActiveMusicbrainz::Model::Artist.by_gid mbid
      raise Headbanger::InvalidTypeError if @object.artist_type.name != 'Person'
    end
  end
end
end
end
