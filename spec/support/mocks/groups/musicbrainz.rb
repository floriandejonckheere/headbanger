# frozen_string_literal: true

module Groups
  class MusicBrainzMock
    def metal_archives_key
      "metal_archives_key"
    end

    def name
      "MusicBrainz Name"
    end

    def alt_names
      ["Name, MusicBrainz"]
    end

    def country
      "BR"
    end

    def description
      "A group from Brazil"
    end

    def formed_on
      Date.new(1999, 12, 31)
    end

    def status
      "split_up"
    end

    def artists
      []
    end
  end
end
