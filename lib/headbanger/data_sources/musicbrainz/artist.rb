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
      raise Headbanger::IncorrectTypeError unless @object.type.name == 'Person'
    end

    delegate :date_begin, :date_end, :to => :object
  end
end
end
end
