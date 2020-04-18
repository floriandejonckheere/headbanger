# frozen_string_literal: true

module Graph
  class GroupBuilder < ApplicationBuilder
    def attributes
      model.name = metal_archives.name
      model.alt_names = metal_archives.aliases
      model.description = Nokogiri::HTML(metal_archives.comment).text
      model.formed_at = metal_archives.date_formed.date
      model.state = metal_archives.status
    end

    def associations
      model.country = CountryBuilder.new(code: metal_archives.country.alpha2).call
      # TODO: model.releases
      # TODO: model.themes
      # TODO: model.genres
    end

    private

    def metal_archives
      @metal_archives ||= MetalArchives::Band.find!(model.metal_archives_key)
    end
  end
end
