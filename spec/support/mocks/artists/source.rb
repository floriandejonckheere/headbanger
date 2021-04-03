# frozen_string_literal: true

module Artists
  class SourceMock < Source
    def metal_archives_key
      "artists.metal_archives_key"
    end

    def musicbrainz_key
      "artists.musicbrainz_key"
    end

    def name
      "artists.name"
    end

    def alt_names
      ["artists.alt_names"]
    end

    def country
      "BE"
    end

    def description
      "artists.description"
    end

    def born_on
      Date.new(2000, 1, 1)
    end

    def died_on
      nil
    end

    def gender
      "male"
    end

    def groups
      [FactoryBot.build(:group, name: "groups.name")]
    end

    def releases
      [FactoryBot.build(:release, name: "releases.name")]
    end
  end
end
