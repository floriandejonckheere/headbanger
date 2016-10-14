module Headbanger
module DataSources
module MetalArchives
  ##
  # Mapping layer for Artist onto Metal Archives API
  #
  class Artist
    attr_accessor :object

    def initialize(id)
      @object = MetalArchives::Artist.find id
    end
  end
end
end
end
