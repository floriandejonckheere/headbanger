module DataSources
module MetalArchives
  class Artist < Base
    attr_accessor :object

    def initialize(id)
      @object = MetalArchives::Artist.find id
    end
  end
end
end
