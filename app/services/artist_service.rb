# frozen_string_literal: true

class ArtistService < AbstractService
  def source_model
    MetalArchives::Artist
  end

  def update_attributes
    # Gender
    instance.gender = @metal_archives.gender&.to_s&.capitalize

    # Date of birth
    instance.date_of_birth = Date.new @musicbrainz.begin_date_year.to_i,
                                      @musicbrainz.begin_date_month.to_i,
                                      @musicbrainz.begin_date_day.to_i

    # Date of death
    instance.date_of_death = Date.new @musicbrainz.end_date_year.to_i,
                                      @musicbrainz.end_date_month.to_i,
                                      @musicbrainz.end_date_day.to_i

    instance.biography = sanitize @metal_archives.biography
  end

  def update_associations
    # Country
    instance.country = @metal_archives.country&.alpha3

    # Names
    instance.names.destroy_all

    primary_name = @musicbrainz.name
    instance.names << Name.new(:name => primary_name, :primary_name => true)

    names = []
    (@musicbrainz.credit_names + @musicbrainz.aliases + @metal_archives.aliases).each do |acn|
      names << acn.name unless acn.name == primary_name
    end

    names.uniq.each { |name| instance.names << Name.new(:name => name) }

    # TODO: Releases
  end
end
