# frozen_string_literal: true

module Graph
  class ReleaseBuilder < ApplicationBuilder
    def attributes
      model.name = metal_archives.title
      model.released_at = metal_archives.date_released&.date
    end

    private

    def metal_archives
      @metal_archives ||= MetalArchives::Release.find!(model.metal_archives_key)
    end
  end
end
