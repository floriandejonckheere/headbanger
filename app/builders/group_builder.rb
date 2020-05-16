# frozen_string_literal: true

class GroupBuilder < ApplicationBuilder
  def attributes
    model.name = metal_archives.name
    model.alt_names = metal_archives.aliases
    model.description = sanitize(metal_archives.comment)
    model.formed_at = metal_archives.date_formed.date
    model.status = metal_archives.status
    model.country = metal_archives.country.alpha2
  end

  def associations
    model.releases = releases
    model.themes = themes
    model.genres = genres
  end

  private

  def metal_archives
    @metal_archives ||= MetalArchives::Band.find!(model.metal_archives_key)
  end

  def releases
    metal_archives
      .releases
      .select { |r| r.type == :full_length }
      .map { |r| ReleaseBuilder.new(metal_archives_key: r.id).call }
  end

  def themes
    metal_archives
      .lyrical_themes
      &.map { |t| ThemeBuilder.new(description: t).call }
  end

  def genres
    metal_archives
      .genres
      .map { |g| GenreBuilder.new(description: g).call }
  end
end
