# frozen_string_literal: true

module Releases
  class Sync
    attr_reader :release, :full, :force

    def initialize(release, full: true, force: false)
      @release = release
      @full = full
      @force = force
    end

    def call
      raise ImportError, "no key available: #{release.inspect}" unless release.metal_archives_key?

      return release if release.synced? && !force

      # Assign attributes
      release.assign_attributes(source.attributes)

      release.musicbrainz_key = source.musicbrainz_key

      # Persist model
      release.save!

      return release unless full

      # Assign associations

      # Set synced_at
      release.update! synced_at: Time.zone.now

      release
    end

    private

    def source
      @source ||= Headbanger.container.resolve("releases.source", metal_archives_key: release.metal_archives_key, musicbrainz_key: release.musicbrainz_key)
    end
  end
end
