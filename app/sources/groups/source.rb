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

    # rubocop:disable Rails/Delegate
    def artists
      metal_archives.artists
    end
    # rubocop:enable Rails/Delegate

    def musicbrainz_key
      @musicbrainz_key ||= find_musicbrainz_key
    end

    private

    def metal_archives
      MetalArchives.new(metal_archives_key)
    end

    def musicbrainz
      @musicbrainz ||= MusicBrainz.new(musicbrainz_key)
    end

    def find_musicbrainz_key
      groups = ActiveBrainz::Artist
        .includes(:artist_type, artist_area: :area_type)
        .where(artist_type: { name: "Group" })

      # Filter by name
      groups = groups
        .where(name: metal_archives.name)

      # TODO: filter by aliases

      return groups.first.gid if groups.one?

      # Filter by country
      groups = groups
        .where(artist_area: { name: metal_archives.country, area_type: { name: "Country" } })

      groups.first.gid if groups.one?
    end
  end
end
