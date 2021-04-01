# frozen_string_literal: true

module Releases
  class MusicBrainzMock
    def metal_archives_key
      "metal_archives_key"
    end

    def name
      "MusicBrainz Name"
    end

    def description
      "A release from 1999"
    end

    def released_at
      Date.new(1999, 12, 31)
    end
  end
end
