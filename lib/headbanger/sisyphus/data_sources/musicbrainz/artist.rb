module Headbanger
module Sisyphus
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

    delegate :begin_date_year,
              :date_end, :to => :object

    # Delegate missing methods to ActiveMusicbrainz
    def method_missing(sym, *args)
      @object.send sym, *args
    end
  end
end
end
end
end
