# frozen_string_literal: true

##
# Artist builder class
#
class ArtistBuilder < DataNodeBuilder
  ##
  # Find or create object
  #
  def find_or_initialize
    raise Headbanger::NoKeyError, "No Metal Archives key specified" unless @metal_archives_key

    @instance = Artist.find_or_initialize_by metal_archives_key: metal_archives_key
  end

  ##
  # Find data sources
  #
  def update_sources
    # Find Metal Archives instance
    @metal_archives = MetalArchives::Artist.find! @metal_archives_key

    # Find Musicbrainz instance
    find_musicbrainz_source
    @instance.musicbrainz_key = @musicbrainz.gid
  end

  ##
  # Update attributes
  #
  def update_attributes
    # Gender
    @instance.gender = @metal_archives.gender&.to_s&.capitalize

    # Date of birth
    dob = @metal_archives.date_of_birth
    if dob.nil? && !(@musicbrainz.begin_date_year.nil? && @musicbrainz.begin_date_month.nil? && @musicbrainz.begin_date_day.nil?)
      dob = "#{@musicbrainz.begin_date_year || 0}-#{@musicbrainz.begin_date_month || 0}-#{@musicbrainz.begin_date_day || 0}"
    end
    @instance.date_of_birth = dob

    # Date of death
    dod = @metal_archives.date_of_death
    if dod.nil? && !(@musicbrainz.end_date_year.nil? && @musicbrainz.end_date_month.nil? && @musicbrainz.end_date_day.nil?)
      dod = "#{@musicbrainz.end_date_year || 0}-#{@musicbrainz.end_date_month || 0}-#{@musicbrainz.end_date_day || 0}"
    end
    @instance.date_of_death = dod

    @instance.biography = sanitize @metal_archives.biography
  end

  ##
  # Update associations
  #
  def update_associations
    # Country
    @instance.country = @metal_archives.country&.alpha3

    # Names
    @instance.names.destroy_all

    primary_name = @musicbrainz.name
    Name.create performer: @instance, name: primary_name, primary: true

    names = []
    (@musicbrainz.credit_names + @musicbrainz.aliases).each do |acn|
      names << acn.name unless acn.name == primary_name
    end

    @metal_archives.aliases.each { |a| names << a unless a == primary_name }

    names.uniq.each { |name| Name.create performer: @instance, name: name }

    # TODO: Releases
  end

  private

  def find_musicbrainz_source
    ([@metal_archives.name] + @metal_archives.aliases).each do |name|
      name.gsub!(/[^a-zA-Z0-9 ]+/, "%")

      query = ActiveMusicbrainz::Model::Artist
        .joins(:area)
        .joins(:type)
        .where "artist.name ILIKE :name", name: name

      if query.one?
        @musicbrainz = query.first
        raise Headbanger::IncorrectTypeError, "Instance must be a person" unless @musicbrainz.type.name == "Person"

        break
      end

      query = query.where "area.name ILIKE :name", name: @metal_archives.country.name

      if query.one?
        @musicbrainz = query.first
        raise Headbanger::IncorrectTypeError, "Instance must be a person" unless @musicbrainz.type.name == "Person"

        break
      end

      query.each do |row|
        next if row.type.name == "Person"

        metal_archives_key = nil

        row.urls.each do |url|
          if url.url.match?(%r{(http:\/\/)?(www.)?metal-archives.com})
            metal_archives_key = url.url.split("/").last
            break
          end
        end

        next unless metal_archives_key == @instance.metal_archives_key

        @musicbrainz = row
        break
      end
    end

    raise Headbanger::NoKeyError, "Could not find Musicbrainz instance for #{@metal_archives_key}" unless @musicbrainz
  end
end
