module Graph
module Data
  class MusicbrainzService
    def self.get_artist(key)
      raise NoDeterminantError unless key
      instance = ActiveMusicbrainz::Model::Artist.by_gid key
      raise IncorrectTypeError unless instance.type.name === 'Person'
    end
  end
end
end
