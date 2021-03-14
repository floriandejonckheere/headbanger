# frozen_string_literal: true

module Artists
  class Sync
    attr_reader :artist

    def initialize(artist)
      @artist = artist
    end

    def call
      return if artist.synced_at > Headbanger.config.data_expires_in.ago

      raise ImportError, "no key available" unless metal_archives_key

      # Keys
      artist.musicbrainz_key = source.musicbrainz_key

      # Attributes
      artist.assign_attributes(source.attributes)

      # Persist model
      artist.synced_at = Time.zone.now

      artist.save!
    end

    private

    def source
      @source ||= Artists::Source.new(metal_archives_key: artist.metal_archives_key, musicbrainz_key: artist.musicbrainz_key)
    end
  end
end
