# frozen_string_literal: true

module Groups
  class MetalArchivesMock
    def metal_archives_key
      "metal_archives_key"
    end

    def name
      "Metal Archives Name"
    end

    def alt_names
      ["Name, Metal Archives"]
    end

    def country
      "BE"
    end

    def description
      "A group from Belgium"
    end

    def formed_on
      Date.new(2000, 1, 1)
    end

    def status
      "active"
    end

    def artists
      []
    end
  end
end
