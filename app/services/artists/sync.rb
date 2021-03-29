# frozen_string_literal: true

module Artists
  class Sync
    attr_reader :artist, :full, :force

    def initialize(artist, full: true, force: false)
      @artist = artist
      @full = full
      @force = force
    end

    def call
      raise ImportError, "no key available" unless artist.metal_archives_key?

      return artist if artist.synced? && !force

      # Assign attributes
      artist.assign_attributes(source.attributes)

      artist.musicbrainz_key = source.musicbrainz_key

      # Persist model
      artist.save!

      return artist unless full

      # Assign associations
      artist.groups.replace(groups)

      # Set synced_at
      artist.update! synced_at: Time.zone.now

      artist
    end

    private

    def groups
      source
        .groups
        .map { |group| Groups::Sync.new(group, full: false).call }
    end

    def source
      @source ||= Headbanger.container.resolve("artists.source", metal_archives_key: artist.metal_archives_key, musicbrainz_key: artist.musicbrainz_key)
    end
  end
end
