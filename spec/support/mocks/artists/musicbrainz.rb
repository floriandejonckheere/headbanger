# frozen_string_literal: true

module Artists
  class MusicBrainzMock
    def musicbrainz_key
      "musicbrainz_key"
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
      "An artist from Brazil"
    end

    def born_on
      Date.new(1999, 12, 31)
    end

    def died_on
      nil
    end

    def gender
      "female"
    end

    def groups
      []
    end
  end
end
