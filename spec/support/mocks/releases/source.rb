# frozen_string_literal: true

module Releases
  class SourceMock < Source
    def metal_archives_key
      "releases.metal_archives_key"
    end

    def musicbrainz_key
      "releases.musicbrainz_key"
    end

    def name
      "releases.name"
    end

    def description
      "releases.description"
    end

    def released_at
      Date.new(2000, 1, 1)
    end
  end
end
