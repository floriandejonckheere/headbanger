module Headbanger
module Sisyphus
module DataSources
module Musicbrainz
  ##
  # Mapping layer for Group onto Musicbrainz database
  #
  class Group
    attr_accessor :object

    def initialize(mbid)
      @object = ActiveMusicbrainz::Model::Artist.by_gid mbid
      raise Headbanger::InvalidTypeError if @object.artist_type.name != 'Group'
    end

    def name
      @object.name
    end

    def year_formed
      Date.new @object.begin_date_year
    end

    def description
      @object.comment
    end

    def country
      area = @object.area
      if area.area_type.name == 'Country'
        ISO3166::Country.find_country_by_name area.name
      else
        nil
      end
    end
  end
end
end
end
end
