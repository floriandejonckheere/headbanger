# frozen_string_literal: true

module Groups
  class MetalArchives
    attr_reader :metal_archives_key

    def initialize(metal_archives_key)
      @metal_archives_key = metal_archives_key
    end

    delegate :name, to: :metal_archives

    def alt_names
      metal_archives.aliases
    end

    def country
      metal_archives.country&.alpha2
    end

    def description
      metal_archives.comment&.sanitize&.squish
    end

    def formed_on
      metal_archives.date_formed
    end

    def status
      metal_archives.status&.to_s
    end

    def artists
      metal_archives
        .members
        .pluck(:id)
        .compact
        .map { |key| Artist.find_or_initialize_by(metal_archives_key: key) }
    end

    private

    def metal_archives
      @metal_archives ||= ::MetalArchives::Band.find(metal_archives_key)
    end
  end
end
