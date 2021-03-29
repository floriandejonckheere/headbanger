# frozen_string_literal: true

module Groups
  class Sync
    attr_reader :group, :full

    def initialize(group, full: true)
      @group = group
      @full = full
    end

    def call
      raise ImportError, "no key available" unless group.metal_archives_key?

      return group if group.synced?

      # Assign attributes
      group.assign_attributes(source.attributes)

      group.musicbrainz_key = source.musicbrainz_key

      # Persist model
      group.save!

      return group unless full

      # Assign associations
      group.genres.replace(genres)
      group.artists.replace(artists)

      # Set synced_at
      group.update! synced_at: Time.zone.now

      group
    end

    private

    def genres
      source
        .genres
        .map { |genre| Genres::Sync.new(genre).call }
    end

    def artists
      source
        .artists
        .map { |artist| Artists::Sync.new(artist, full: false).call }
    end

    def source
      @source ||= Headbanger.container.resolve("groups.source", metal_archives_key: group.metal_archives_key, musicbrainz_key: group.musicbrainz_key)
    end
  end
end
