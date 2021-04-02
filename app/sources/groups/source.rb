# frozen_string_literal: true

module Groups
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
      (metal_archives.alt_names + musicbrainz.alt_names)&.uniq
    end

    def country
      metal_archives.country || musicbrainz.country
    end

    def description
      metal_archives.description || musicbrainz.description
    end

    def formed_on
      metal_archives.formed_on || musicbrainz.formed_on
    end

    def status
      metal_archives.status || musicbrainz.status
    end

    def attributes
      {
        name: name,
        alt_names: alt_names,
        country: country,
        description: description,
        formed_on: formed_on,
        status: status,
      }
    end

    def genres
      metal_archives.genres
    end

    def themes
      metal_archives.themes
    end

    def artists
      # FIXME: use MusicBrainz' artists as well
      metal_archives.artists
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
      @metal_archives ||= Headbanger.container.resolve("groups.metal_archives", metal_archives_key)
    end

    def musicbrainz
      @musicbrainz ||= Headbanger.container.resolve("groups.musicbrainz", musicbrainz_key)
    end

    def find_musicbrainz_key
      groups = ActiveBrainz::Artist
        .includes(:artist_type, :artist_aliases, artist_area: [:area_type, :area_iso_3166_1, :area_iso_3166_2])
        .where(artist_type: { name: "Group" })

      # Filter by name
      groups = groups
        .where(name: metal_archives.name)

      return groups.first.gid if groups.one?

      # Filter by country
      groups = groups
        .where(artist_area: { area_type: { name: "Country" }, iso_3166_1: { code: metal_archives.country } })

      # Or subdivision
      subdivisions = ISO3166::Country[metal_archives.country].subdivisions.keys.map { |s| "#{metal_archives.country}-#{s}" }

      groups = groups
        .or(groups.where(artist_area: { area_type: { name: "Subdivision" }, iso_3166_2: { code: subdivisions } }))

      return groups.first.gid if groups.one?

      # Filter by aliases
      groups = groups
        .where(artist_aliases: { name: metal_archives.alt_names }) if metal_archives.alt_names.any?

      groups.first.gid if groups.one?
    end
  end
end
