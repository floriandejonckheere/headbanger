# frozen_string_literal: true

module Artists
  module Sources
    class MetalArchives
      attr_reader :metal_archives_key

      def initialize(metal_archives_key)
        super

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

      delegate :gender, to: :metal_archives

      private

      def metal_archives
        @metal_archives ||= ::MetalArchives::Artist.find(metal_archives_key)
      end
    end
  end
end
