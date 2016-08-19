class ArtistWorker < BaseWorker
  ### Attribute -> data source mapping ###
  attribute [:date_of_birth, :date_of_death],
              :source => :musicbrainz,
              :valid_for => 3.months

  association [:names, :groups, :releases],
                :source => [:musicbrainz, :metal_archives],
                :valid_for => 3.months

  ### Data source lookup ###
  def musicbrainz(key)
    artist = Musicbrainz::Artist.find_by_mbid key
  end

  def metal_archives(key)
    raise Errors::NotImplementedError
  end

  def discogs(key)
    raise Errors::NotImplementedError
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

  def groups
  end

  def releases
  end
end
