# frozen_string_literal: true

module Artists
  module Sources
    class MusicBrainz
      attr_reader :musicbrainz_key

      def initialize(musicbrainz_key)
        super

        @musicbrainz_key = musicbrainz_key
      end

      delegate :name, to: :musicbrainz

      def alt_names
        musicbrainz.artist_aliases.map(&:name)
      end

      def country
        return unless musicbrainz.artist_area

        ISO3166::Country
          .find_country_by_name(musicbrainz.artist_area.name)
          .alpha2
      end

      def description
        musicbrainz.comment.presence
      end

      def born_on
        musicbrainz.begin_date
      end

      def died_on
        musicbrainz.end_date
      end

      def gender
        musicbrainz.artist_gender&.name&.downcase
      end

      private

      def musicbrainz
        @musicbrainz ||= ActiveBrainz::Artist
          .includes(:artist_type, artist_area: :area_type)
          .where(artist_type: { name: "Person" })
          .find_by!(gid: musicbrainz_key)
      end
    end
  end
end
