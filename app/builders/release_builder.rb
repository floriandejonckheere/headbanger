# frozen_string_literal: true

##
# Release builder class
#
class ReleaseBuilder < DataNodeBuilder
  ##
  # Find or create object
  #
  def find_or_initialize
    raise Headbanger::NoKeyError, 'No Metal Archives key specified' unless @metal_archives_key

    @instance = Release.find_or_initialize_by :metal_archives_key => metal_archives_key
  end

  ##
  # Find data sources
  #
  def update_sources
    # Find Metal Archives instance
    @metal_archives = MetalArchives::Release.find! @metal_archives_key

    # Find Musicbrainz instance
    find_musicbrainz_source
    @instance.musicbrainz_key = @musicbrainz.gid
  end

  ##
  # Update attributes
  #
  def update_attributes
    # Title
    @instance.title = @metal_archives.title

    # Release date
    @instance.year = @metal_archives.date_released.year
  end

  ##
  # Update associations
  #
  def update_associations
    # TODO: Groups
    # TODO: Artists
  end

  private

  def find_musicbrainz_source
    name = @metal_archives.title.gsub /[^a-zA-Z0-9 ]+/, '%'

    query = ActiveMusicbrainz::Model::ReleaseGroup
              .where 'release_group.name ILIKE :name', :name => name

    return @musicbrainz = query.first if query.one?

    raise Headbanger::NoKeyError, "Could not find Musicbrainz instance for #{@metal_archives_key}" unless @musicbrainz
  end
end
