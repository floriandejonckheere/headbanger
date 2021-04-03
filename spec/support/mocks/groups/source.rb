# frozen_string_literal: true

module Groups
  class SourceMock < Source
    def metal_archives_key
      "groups.metal_archives_key"
    end

    def musicbrainz_key
      "groups.musicbrainz_key"
    end

    def name
      "groups.name"
    end

    def alt_names
      ["groups.alt_names"]
    end

    def country
      "BE"
    end

    def description
      "groups.description"
    end

    def formed_on
      Date.new(2000, 1, 1)
    end

    def status
      "active"
    end

    def genres
      [FactoryBot.build(:genre, name: "power")]
    end

    def themes
      [FactoryBot.build(:theme, name: "groups.theme")]
    end

    def artists
      [FactoryBot.build(:artist, name: "artists.name")]
    end

    def releases
      [FactoryBot.build(:release, name: "releases.name")]
    end
  end
end
