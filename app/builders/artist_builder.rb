# frozen_string_literal: true

class ArtistBuilder < ApplicationBuilder
  def attributes
    model.name = metal_archives.name
    model.alt_names = metal_archives.aliases
    model.description = metal_archives.biography.sanitize
    model.born_at = metal_archives.date_of_birth&.date
    model.died_at = metal_archives.date_of_death&.date
    model.gender = metal_archives.gender
    model.country = metal_archives.country.alpha2
  end

  def associations
    model.groups = groups
    # TODO: model.releases
  end

  private

  def metal_archives
    @metal_archives ||= MetalArchives::Artist.find!(model.metal_archives_key)
  end

  def groups
    metal_archives
      .bands
      .pluck(:band)
      .select { |b| b.respond_to? :id }
      .map { |b| GroupBuilder.new(metal_archives_key: b.id).call }
  end
end
