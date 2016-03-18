class ArtistWorker < BaseWorker
  ### Attribute -> data source mapping ###
  attribute [:date_of_birth, :date_of_death],
              :source => :musicbrainz,
              :valid_for => 3.months

  association :names,
                :source => [:musicbrainz, :metal_archives],
                :valid_for => 3.months

  ### Data source lookup ###
  def musicbrainz(key)
    Musicbrainz::Artist.find_by_mbid key
  end

  def metal_archives(key)
    raise 'Not implemented yet'
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
end
