module Graph
module Data
  class MetalArchivesService
    def self.get_artist(key)
      raise NoDeterminantError unless key
      instance = MetalArchives::Artist.find key
    end
  end
end
end
