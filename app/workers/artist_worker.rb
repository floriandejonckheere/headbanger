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
  def names
    raise Errors::NotImplementedError
  end

  def groups
    raise Errors::NotImplementedError
  end

  def releases
    raise Errors::NotImplementedError
  end
end
