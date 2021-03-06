# frozen_string_literal: true

module Groups
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

    def formed_on
      musicbrainz&.begin_date
    end

    def status
      nil
    end

    def artists
      # TODO: artist association
      []
    end

    def releases
      musicbrainz
        .artist_credit_names
        .flat_map do |artist_credit_name|
        artist_credit_name
          .artist_credit_name_artist_credit
          .release_groups
          .map { |release_group| Release.find_or_initialize_by(musicbrainz_key: release_group.gid) }
      end
    end

    private

    def musicbrainz
      return unless musicbrainz_key

      @musicbrainz ||= ActiveBrainz::Artist
        .includes(:artist_type, :artist_aliases, artist_area: [:area_type, :area_iso_3166_1])
        .includes(artist_credit_names: { artist_credit_name_artist_credit: :release_groups })
        .where(artist_type: { name: "Group" })
        .find_by!(gid: musicbrainz_key)
    end
  end
end
