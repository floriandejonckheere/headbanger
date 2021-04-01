# frozen_string_literal: true

module Releases
  class MusicBrainz
    attr_reader :musicbrainz_key

    def initialize(musicbrainz_key)
      @musicbrainz_key = musicbrainz_key
    end

    delegate :name, to: :musicbrainz

    def description
      musicbrainz&.comment&.presence
    end

    private

    def musicbrainz
      return unless musicbrainz_key

      @musicbrainz ||= ActiveBrainz::ReleaseGroup
        .find_by!(gid: musicbrainz_key)
    end
  end
end
