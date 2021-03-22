# frozen_string_literal: true

module Artists
  class Source
    attr_reader :metal_archives_key

    def initialize(metal_archives_key: nil, musicbrainz_key: nil)
      @metal_archives_key = metal_archives_key
      @musicbrainz_key = musicbrainz_key
    end

    def name
      metal_archives.name || musicbrainz.name
    end

    def alt_names
      (metal_archives.alt_names + musicbrainz.alt_names).uniq
    end

    def country
      metal_archives.country || musicbrainz.country
    end

    def description
      metal_archives.description || musicbrainz.description
    end

    def born_on
      metal_archives.born_on || musicbrainz.born_on
    end

    def died_on
      metal_archives.died_on || musicbrainz.died_on
    end

    def gender
      metal_archives.gender || musicbrainz.gender
    end

    def attributes
      {
        name: name,
        alt_names: alt_names,
        country: country,
        description: description,
        born_on: born_on,
        died_on: died_on,
        gender: gender,
      }
    end

    def groups
      metal_archives.groups
    end

    def musicbrainz_key
      @musicbrainz_key ||= find_musicbrainz_key
    end

    private

    def metal_archives
      @metal_archives ||= MetalArchives.new(metal_archives_key)
    end

    def musicbrainz
      @musicbrainz ||= MusicBrainz.new(musicbrainz_key)
    end

    def find_musicbrainz_key
      artists = ActiveBrainz::Artist
        .includes(:artist_type, artist_area: [:area_type, :area_iso_3166_1])
        .where(artist_type: { name: "Person" })

      # Filter by name
      artists = artists
        .where(name: metal_archives.name)

      # TODO: filter by aliases

      return artists.first.gid if artists.one?

      # Filter by country
      artists = artists
        .where(artist_area: { area_type: { name: "Country" }, area_iso_3166_1: { code: metal_archives.country } })

      artists.first.gid if artists.one?
    end
  end
end
