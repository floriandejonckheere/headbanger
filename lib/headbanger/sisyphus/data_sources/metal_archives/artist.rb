module Headbanger
module Sisyphus
module DataSources
module MetalArchives
  ##
  # Mapping layer for Artist onto Metal Archives API
  #
  class Artist
    attr_accessor :object

    def initialize(id)
    end

    def biography
      'Stub biography'
    end

    def country
      'Belgium'
    end

    def names
      []
    end

    def groups
      []
    end

    def releases
      []
    end
  end
end
end
end
end
