# frozen_string_literal: true

module Groups
  class Sync
    attr_reader :group, :full, :force

    def initialize(group, full: true, force: false)
      @group = group
      @full = full
      @force = force
    end

    # rubocop:disable Metrics/AbcSize
    def call
      raise ImportError, "no key available" unless group.metal_archives_key?

      return group if group.synced? && !force

      # Assign attributes
      group.assign_attributes(source.attributes)

      group.musicbrainz_key = source.musicbrainz_key

      # Persist model
      group.save!

      return group unless full

      # Assign associations
      group.genres.replace(genres)
      group.themes.replace(themes)

      group.artists.replace(artists)
      group.releases.replace(releases)

      # Set synced_at
      group.update! synced_at: Time.zone.now

      group
    end
    # rubocop:enable Metrics/AbcSize

    private

    def genres
      source
        .genres
        .map { |genre| Genres::Sync.new(genre).call }
    end

    def themes
      source
        .themes
        .map { |theme| Themes::Sync.new(theme).call }
    end

    def artists
      source
        .artists
        .map { |artist| Artists::Sync.new(artist, full: false).call }
    end

    def releases
      source
        .releases
        .map { |release| Releases::Sync.new(release, full: false).call }
    end

    def source
      @source ||= Headbanger.container.resolve("groups.source", metal_archives_key: group.metal_archives_key, musicbrainz_key: group.musicbrainz_key)
    end
  end
end
