class ArtistWorker < BaseWorker
  ### Attribute -> data source mapping ###
  attribute [:date_of_birth, :date_of_death],
              :source => :musicbrainz,
              :valid_for => 3.months

  association [:names, :groups, :releases],
                :source => [:musicbrainz, :metal_archives],
                :valid_for => 3.months

  model :artist

  ### Attributes ###
  def date_of_birth
    return Date.new @musicbrainz.begin_date_year.to_i,
                      @musicbrainz.begin_date_month.to_i,
                      @musicbrainz.begin_date_day.to_i
  rescue ArgumentError
    # Invalid date (one or more args is nil)
    return nil
  end

  def date_of_death
    return Date.new @musicbrainz.end_date_year.to_i,
                      @musicbrainz.end_date_month.to_i,
                      @musicbrainz.end_date_day.to_i
  rescue ArgumentError
    # Invalid date (one or more args is nil)
    return nil
  end

  ### Associations ###
  def names(instance)
    instance.names.delete_all
    instance.names << Graph::Name.create!(:name => @musicbrainz.name)
  end

  def groups(instance)
    logger.error 'Not implemented yet'
  end

  def releases(instance)
    @musicbrainz.release_groups.each do |release_group|
      # TODO: accept more than just albums
      next unless release_group.type == 'Album'
    end
  end
end
