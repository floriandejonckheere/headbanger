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
      # FIXME: use MusicBrainz' groups as well
      metal_archives.groups
    end

    def releases
      # FIXME: use MusicBrainz' releases as well
      metal_archives.releases
    end

    def musicbrainz_key
      @musicbrainz_key ||= find_musicbrainz_key
    end

    private

    def metal_archives
      @metal_archives ||= Headbanger.container.resolve("artists.metal_archives", metal_archives_key)
    end

    def musicbrainz
      @musicbrainz ||= Headbanger.container.resolve("artists.musicbrainz", musicbrainz_key)
    end

    def find_musicbrainz_key
      artists = ActiveBrainz::Artist
        .includes(:artist_type, :artist_aliases, artist_area: [:area_type, :area_iso_3166_1, :area_iso_3166_2])
        .where(artist_type: { name: "Person" })

      # Filter by name
      artists = artists
        .where(name: metal_archives.name)

      return artists.first.gid if artists.one?

      # Filter by country
      artists = artists
        .where(artist_area: { area_type: { name: "Country" }, iso_3166_1: { code: metal_archives.country } })

      # Or subdivision
      subdivisions = ISO3166::Country[metal_archives.country].subdivisions.keys.map { |s| "#{metal_archives.country}-#{s}" }

      artists = artists
        .or(artists.where(artist_area: { area_type: { name: "Subdivision" }, iso_3166_2: { code: subdivisions } }))

      return artists.first.gid if artists.one?

      # Filter by aliases
      artists = artists
        .where(artist_aliases: { name: metal_archives.alt_names }) if metal_archives.alt_names.any?

      artists.first.gid if artists.one?
    end
  end
end
