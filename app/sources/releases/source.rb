# frozen_string_literal: true

module Releases
  class Source
    attr_reader :metal_archives_key

    def initialize(metal_archives_key: nil, musicbrainz_key: nil)
      @metal_archives_key = metal_archives_key
      @musicbrainz_key = musicbrainz_key
    end

    def name
      metal_archives.name || musicbrainz.name
    end

    def description
      metal_archives.description || musicbrainz.description
    end

    def released_at
      metal_archives.released_at
    end

    def attributes
      {
        name: name,
        description: description,
        released_at: released_at,
      }
    end

    def musicbrainz_key
      @musicbrainz_key ||= find_musicbrainz_key
    end

    private

    def metal_archives
      @metal_archives ||= Headbanger.container.resolve("releases.metal_archives", metal_archives_key)
    end

    def musicbrainz
      @musicbrainz ||= Headbanger.container.resolve("releases.musicbrainz", musicbrainz_key)
    end

    def find_musicbrainz_key; end
  end
end
