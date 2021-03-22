# frozen_string_literal: true

module Artists
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
      "An artist from Belgium"
    end

    def born_on
      Date.new(2000, 1, 1)
    end

    def died_on
      nil
    end

    def gender
      "male"
    end

    def groups
      []
    end
  end
end
