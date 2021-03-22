# frozen_string_literal: true

module Artists
  class MusicBrainz
    attr_reader :musicbrainz_key

    def initialize(musicbrainz_key)
      @musicbrainz_key = musicbrainz_key
    end

    delegate :name, to: :musicbrainz

    def alt_names
      musicbrainz&.artist_aliases&.map(&:name) || []
    end

    def country
      musicbrainz
        &.artist_area
        &.area_iso_3166_1
        &.code
    end

    def description
      musicbrainz&.comment&.presence
    end

    def born_on
      musicbrainz&.begin_date
    end

    def died_on
      musicbrainz&.end_date
    end

    def gender
      musicbrainz&.artist_gender&.name&.downcase
    end

    def groups
      # TODO: group association
      []
    end

    private

    def musicbrainz
      return unless musicbrainz_key

      @musicbrainz ||= ActiveBrainz::Artist
        .includes(:artist_type, :artist_aliases, artist_area: [:area_type, :area_iso_3166_1])
        .where(artist_type: { name: "Person" })
        .find_by!(gid: musicbrainz_key)
    end
  end
end
