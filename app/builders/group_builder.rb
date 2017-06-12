# frozen_string_literal: true

##
# Group builder class
#
class GroupBuilder < DataNodeBuilder
  ##
  # Find or create object
  #
  def find_or_initialize
    raise Headbanger::NoKeyError, 'No Metal Archives key specified' unless @metal_archives_key

    @instance = Group.find_or_initialize_by :metal_archives_key => metal_archives_key
  end

  ##
  # Find data sources
  #
  def update_sources
    # Find Metal Archives instance
    @metal_archives = MetalArchives::Band.find! @metal_archives_key

    # Find Musicbrainz instance
    find_musicbrainz_source
    @instance.musicbrainz_key = @musicbrainz.gid
  end

  ##
  # Update attributes
  #
  def update_attributes
    # Year formed
    @instance.year_formed = @metal_archives.date_formed
    unless @instance.year_formed
      dof = "#{@musicbrainz.begin_date_year || 0}-#{@musicbrainz.begin_date_month || 0}-#{@musicbrainz.begin_date_day || 0}"
      @instance.year_formed = dof
    end

    # Description
    @instance.description = @metal_archives.comment

    # Status
    @instance.status = @metal_archives.status
  end

  ##
  # Update associations
  #
  def update_associations
    # Country
    country = @metal_archives.country&.alpha3

    if country
      @instance.country = Country.find_or_create_by :country => country
    else
      warn 'No country found'
    end

    # Names
    @instance.names.destroy_all

    primary_name = @musicbrainz.name
    Name.create :performer => @instance, :name => primary_name, :primary => true

    names = []
    (@musicbrainz.credit_names + @musicbrainz.aliases).each do |acn|
      names << acn.name unless acn.name == primary_name
    end

    @metal_archives.aliases.each { |a| names << a unless a == primary_name }

    names.uniq.each { |name| Name.create :performer => @instance, :name => name }

    # TODO: Artists
    # TODO: Lyrical themes
    # TODO: Genres
    # TODO: Releases
  end

  private

  def find_musicbrainz_source
    name = @metal_archives.name.gsub(/[^a-zA-Z0-9 ]+/, '%')

    query = ActiveMusicbrainz::Model::Artist.joins(:area)
              .joins(:type)
              .where 'artist.name ILIKE :name', :name => name

    if query.one?
      @musicbrainz = query.first
      raise Headbanger::IncorrectTypeError, 'Instance must be a person' unless @musicbrainz.type.name == 'Group'

      return
    end

    query = query.where 'area.name ILIKE :name', :name => @metal_archives.country.name

    if query.one?
      @musicbrainz = query.first
      raise Headbanger::IncorrectTypeError, 'Instance must be a person' unless @musicbrainz.type.name == 'Group'

      return
    end

    query.each do |row|
      next if row.type.name == 'Person'

      metal_archives_key = nil

      row.urls.each do |url|
        if url.url.match?(%r{(http:\/\/)?(www.)?metal-archives.com})
          metal_archives_key = url.url.split('/').last
          break
        end
      end

      next unless metal_archives_key == @instance.metal_archives_key

      @musicbrainz = row
      break
    end

    raise Headbanger::NoKeyError, 'Could not find Musicbrainz instance' unless @musicbrainz
  end
end
