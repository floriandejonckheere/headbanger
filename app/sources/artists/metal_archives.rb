# frozen_string_literal: true

module Artists
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
      metal_archives.biography&.sanitize&.squish
    end

    def born_on
      metal_archives.date_of_birth
    end

    def died_on
      metal_archives.date_of_death
    end

    def gender
      metal_archives.gender&.to_s
    end

    def groups
      metal_archives
        .bands
        .pluck(:id)
        .compact
        .map { |key| Group.find_or_initialize_by(metal_archives_key: key) }
    end

    private

    def metal_archives
      @metal_archives ||= ::MetalArchives::Artist.find(metal_archives_key)
    end
  end
end
