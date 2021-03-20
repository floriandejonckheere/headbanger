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
      return unless musicbrainz&.artist_area

      ISO3166::Country
        .find_country_by_name(musicbrainz.artist_area.name)
        .alpha2
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

    private

    def musicbrainz
      return unless musicbrainz_key

      @musicbrainz ||= ActiveBrainz::Artist
        .includes(:artist_type, artist_area: :area_type)
        .where(artist_type: { name: "Group" })
        .find_by!(gid: musicbrainz_key)
    end
  end
end
