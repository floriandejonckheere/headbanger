# frozen_string_literal: true

module Releases
  class MetalArchives
    attr_reader :metal_archives_key

    def initialize(metal_archives_key)
      @metal_archives_key = metal_archives_key
    end

    def name
      metal_archives.title
    end

    def description
      metal_archives.comment&.sanitize&.squish
    end

    def released_at
      metal_archives.released_at
    end

    private

    def metal_archives
      @metal_archives ||= ::MetalArchives::Release.find(metal_archives_key)
    end
  end
end
