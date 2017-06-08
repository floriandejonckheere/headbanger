# frozen_string_literal: true

class GroupService < AbstractService
  def source_model
    MetalArchives::Band
  end

  def update_attributes
    # Year formed
    instance.year_formed = @metal_archives.date_formed
    unless instance.year_formed
      dof = "#{@musicbrainz.begin_date_year || 0}-#{@musicbrainz.begin_date_month || 0}-#{@musicbrainz.begin_date_day || 0}"
      instance.year_formed = dof
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
end
