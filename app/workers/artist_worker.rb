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
    @musicbrainz.date_begin
  end

  def date_of_death
    @musicbrainz.date_end
  end

  ### Associations ###
  def names(instance)
    instance.names.delete_all
    instance.names << Graph::Name.create!(:name => @musicbrainz.name)
  end

  def groups(instance)
    raise Headbanger::IncorrectTypeError unless @musicbrainz.type == 'Person'
    logger.error 'Not implemented yet'
  end

  def releases(instance)
    @musicbrainz.release_groups.each do |release_group|
      # TODO: accept more than just albums
      next unless release_group.type == 'Album'
    end
  end
end
