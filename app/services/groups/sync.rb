# frozen_string_literal: true

module Groups
  class Sync
    attr_reader :group

    def initialize(group)
      @group = group
    end

    def call
      raise ImportError, "no key available" unless group.metal_archives_key?

      # Keys
      group.musicbrainz_key = source.musicbrainz_key

      # Attributes
      group.assign_attributes(source.attributes)

      # Persist model
      group.synced_at = Time.zone.now

      group.save!
    end

    private

    def source
      @source ||= Headbanger.container.resolve("groups.source", metal_archives_key: group.metal_archives_key, musicbrainz_key: group.musicbrainz_key)
    end
  end
end
