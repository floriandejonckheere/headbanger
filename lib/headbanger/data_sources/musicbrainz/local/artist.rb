module Headbanger
module DataSources
module Musicbrainz
module Local
  class Artist
    attr_accessor :object

    def initialize(id)
      @object = Musicbrainz::Artist.find_by_mbid id
    end

    def date_begin
      return Date.new @object.begin_date_year.to_i || 0,
                        @object.begin_date_month.to_i || 1,
                        @object.begin_date_day.to_i || 1
    end

    def date_end
      return Date.new @object.end_date_year.to_i || 0,
                        @object.end_date_month.to_i || 1,
                        @object.end_date_day.to_i || 1
    end
  end
end
end
end
end
