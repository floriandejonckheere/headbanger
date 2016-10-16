module Sisyphus
module Headbanger
  class GroupWorker < BaseWorker
    ### Attribute -> data source mapping ###
    attribute [:country, :year_formed],
                :source => :musicbrainz,
                :valid_for => 3.months

    association [:names, :lyrical_themes, :releases],
                  :source => [:musicbrainz, :metal_archives],
                  :valid_for => 3.months

    ### Data source lookup ###
    def musicbrainz(key)
      artist = Musicbrainz::Artist.find_by_mbid key
    end


    ### Attributes ###
    def date_of_birth
      begin
        return Date.new @musicbrainz.begin_date_year.to_i,
                          @musicbrainz.begin_date_month.to_i,
                          @musicbrainz.begin_date_day.to_i
      rescue ArgumentError
        # Invalid date (one or more args is nil)
        return nil
      end
    end

    def date_of_death
      begin
        return Date.new @musicbrainz.end_date_year.to_i,
                          @musicbrainz.end_date_month.to_i,
                          @musicbrainz.end_date_day.to_i
      rescue ArgumentError
        # Invalid date (one or more args is nil)
        return nil
      end
    end

    ### Associations ###
    def names
      @object.names.delete_all

      @object.names << Graph::Name.create!(:name => @musicbrainz.name)
      @musicbrainz.artist_aliases.each do |artist_alias|
        @object.names << Graph::Name.create!(:name => artist_alias.name)
      end
    end

    def lyrical_themes
    end

    def releases
    end
  end
end
end
