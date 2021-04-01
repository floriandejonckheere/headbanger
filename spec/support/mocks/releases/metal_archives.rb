# frozen_string_literal: true

module Releases
  class MetalArchivesMock
    def metal_archives_key
      "metal_archives_key"
    end

    def name
      "Metal Archives Name"
    end

    def description
      "A release from 2000"
    end

    def released_at
      Date.new(2000, 1, 1)
    end
  end
end
