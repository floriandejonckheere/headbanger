# frozen_string_literal: true

module Artists
  class Import
    attr_reader :metal_archives_key, :musicbrainz_key, :artist

    def initialize(metal_archives_key:, musicbrainz_key: nil)
      @metal_archives_key = metal_archives_key
      @musicbrainz_key = musicbrainz_key

      @artist = Artist.find_or_initialize_by(metal_archives_key: metal_archives_key)
    end

    # rubocop:disable Metrics/AbcSize
    def call
      # Attributes
      artist.name = metal_archives.name
      artist.alt_names = (metal_archives.alt_names + musicbrainz.alt_names)&.uniq
      artist.country = metal_archives.country || musicbrainz.country
      artist.description = metal_archives.description || musicbrainz.description
      artist.born_on = metal_archives.born_on || musicbrainz.born_on
      artist.died_on = metal_archives.died_on || musicbrainz.died_on
      artist.gender = metal_archives.gender || musicbrainz.gender

      # Persist model
      artist.synced_at = Time.zone.now

      artist.save!
    end
    # rubocop:enable Metrics/AbcSize

    private

    def metal_archives
      Sources::MetalArchives.new(metal_archives_key)
    end

    def musicbrainz
      @musicbrainz ||= find_musicbrainz
    end

    def find_musicbrainz
      artists = ActiveBrainz::Artist
        .includes(:artist_type, artist_area: :area_type)
        .where(artist_type: { name: "Person" })

      # Filter by name
      artists = artists
        .where(name: metal_archives.name)

      # TODO: filter by aliases

      return Sources::MusicBrainz.new(artists.first.gid) if artists.one?

      # Filter by country
      artists = artists
        .where(artist_area: { name: metal_archives.country, area_type: { name: "Country" } })

      Sources::MusicBrainz.new(artists.first.gid) if artists.one?
    end
  end
end
