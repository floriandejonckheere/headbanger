# frozen_string_literal: true

module Artists
  class Import
    attr_reader :metal_archives_key, :musicbrainz_key, :artist

    def initialize(metal_archives_key: nil, musicbrainz_key: nil)
      @metal_archives_key = metal_archives_key
      @musicbrainz_key = musicbrainz_key

      @artist = Artist.find_or_initialize_by(metal_archives_key: metal_archives_key)
    end

    def call
      raise ImportError, "no key available" unless metal_archives_key || musicbrainz_key

      # Keys
      artist.metal_archives_key = source.metal_archives_key
      artist.musicbrainz_key = source.musicbrainz_key

      # Attributes
      artist.assign_attributes(source.attributes)

      # Persist model
      artist.synced_at = Time.zone.now

      artist.save!
    end

    private

    def source
      @source ||= Artists::Source.new(metal_archives_key: metal_archives_key, musicbrainz_key: musicbrainz_key)
    end
  end
end
