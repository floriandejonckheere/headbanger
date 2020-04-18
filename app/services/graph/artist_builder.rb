# frozen_string_literal: true

module Graph
  class ArtistBuilder < ApplicationBuilder
    def attributes
      model.name = metal_archives.name
      model.alt_names = metal_archives.aliases
      model.description = Nokogiri::HTML(metal_archives.biography).text
      model.born_at = metal_archives.date_of_birth&.date
      model.died_at = metal_archives.date_of_death&.date
      model.gender = metal_archives.gender
    end

    def associations
      model.country = Graph::CountryBuilder.new(code: metal_archives.country.alpha2).call
      model.groups = groups
    end

    private

    def metal_archives
      @metal_archives ||= MetalArchives::Artist.find!(model.metal_archives_key)
    end

    def groups
      @bands ||= metal_archives
        .bands
        .map { |b| b[:band] }
        .select { |b| b.respond_to? :id }
        .map { |b| Graph::Group.find_or_initialize_by(metal_archives_key: b.id) }
    end
  end
end
