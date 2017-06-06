# frozen_string_literal: true

class GroupService < AbstractService
  def model
    Group
  end

  def enumerate
    MetalArchives::Band.all
  end

  def update_instance
    source_instance
    update_attributes
    update_associations

    instance.save
  end

  protected

  def source_instance
    # Find MA instance
    @metal_archives = MetalArchives::Band.find! instance.metal_archives_key

    # Try to find musicbrainz instance
    find_musicbrainz_instance
  end

  def update_attributes
    # Year formed
    instance.year_formed = @metal_archives.date_formed
    unless instance.year_formed
      instance.year_formed = Date.new @musicbrainz.begin_date_year.to_i,
                                      @musicbrainz.begin_date_month.to_i,
                                      @musicbrainz.begin_date_day.to_i
    end

    # Description
    instance.description = @metal_archives.comment

    # Status
    instance.status = @metal_archives.status
  end

  def update_associations
    # Country
    country = @metal_archives.country&.alpha3

    if country
      instance.country = Country.find_or_create_by :country => country
    else
      warn 'No country found'
    end

    # Names
    instance.names.destroy_all

    primary_name = @musicbrainz.name
    instance.names << Name.new(:name => primary_name, :primary => true)

    names = []
    (@musicbrainz.credit_names + @musicbrainz.aliases + @metal_archives.aliases).each do |acn|
      names << acn.name unless acn.name == primary_name
    end

    names.uniq.each { |name| instance.names << Name.new(:name => name) }

    # TODO: Artists
    # TODO: Lyrical themes
    # TODO: Genres
    # TODO: Releases
  end

  def find_musicbrainz_instance
    query = ActiveMusicbrainz::Model::Artist.joins(:area)
                                            .joins(:type)
                                            .where 'artist.name ILIKE :name', :name => @metal_archives.name

    if query.one?
      @musicbrainz = query.first
      raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name == 'Group'

      return
    end

    query = query.where 'area.name ILIKE :name', :name => @metal_archives.country.name

    if query.one?
      @musicbrainz = query.first
      raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name == 'Group'

      return
    end

    query.each do |band|
      next if band.type.name == 'Group'

      band.urls.each do |url|
        if url.url.match?(/(http:\/\/)?(www.)?metal-archives.com/)
          metal_archives_key = url.url.split('/').last
          break
        end
      end

      next unless metal_archives_key == instance.metal_archives_key
      instance.musicbrainz_key = @musicbrainz.gid

      @musicbrainz = band
      break
    end

    raise Headbanger::NoKeyError unless @musicbrainz
  end
end
