class ArtistWorker < BaseWorker
  ### Attribute -> data source mapping ###
  attribute [:date_of_birth, :date_of_death],
              :source => :musicbrainz,
              :valid_for => 3.months

  association [:names, :groups, :releases],
                :source => [:musicbrainz, :metal_archives],
                :valid_for => 3.months

  model 'artist'

  ### Attributes ###
  def date_of_birth
    @musicbrainz.date_begin
  end

  def date_of_death
    @musicbrainz.date_end
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
