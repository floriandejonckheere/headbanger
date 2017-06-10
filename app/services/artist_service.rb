# frozen_string_literal: true

class ArtistService < AbstractService
  def source_model
    MetalArchives::Artist
  end

  def update_attributes
    # Gender
    instance.gender = @metal_archives.gender&.to_s&.capitalize

    # Date of birth
    dob = @metal_archives.date_of_birth
    if dob.nil? && !(@musicbrainz.begin_date_year.nil? && @musicbrainz.begin_date_month.nil? && @musicbrainz.begin_date_day.nil?)
      dob = "#{@musicbrainz.begin_date_year || 0}-#{@musicbrainz.begin_date_month || 0}-#{@musicbrainz.begin_date_day || 0}"
    end
    instance.date_of_birth = dob

    # Date of death
    dod = @metal_archives.date_of_death
    if dod.nil? && !(@musicbrainz.end_date_year.nil? && @musicbrainz.end_date_month.nil? && @musicbrainz.end_date_day.nil?)
      dod = "#{@musicbrainz.end_date_year || 0}-#{@musicbrainz.end_date_month || 0}-#{@musicbrainz.end_date_day || 0}"
    end
    instance.date_of_death = dod

    instance.biography = sanitize @metal_archives.biography
  end

  def update_associations
    # Country
    instance.country = @metal_archives.country&.alpha3

    # Names
    instance.names.destroy_all

    primary_name = @musicbrainz.name
    Name.create :performer => instance, :name => primary_name, :primary => true

    names = []
    (@musicbrainz.credit_names + @musicbrainz.aliases + @metal_archives.aliases).each do |acn|
      names << acn.name unless acn.name == primary_name
    end

    names.uniq.each { |name| Name.create :performer => instance, :name => name }

    # TODO: Releases
  end
end
