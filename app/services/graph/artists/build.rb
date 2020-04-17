# frozen_string_literal: true

module Graph
  module Artists
    class Build
      attr_accessor :model

      def initialize(id:)
        @model = Graph::Artist.find_or_initialize_by(metal_archives_key: id)
      end

      def call
        # Do not build recent models
        return model if model.fresh?

        # Assemble attributes
        model.name = metal_archives.name
        model.alt_names = metal_archives.aliases
        model.description = Nokogiri::HTML(metal_archives.biography).text
        model.born_at = metal_archives.date_of_birth&.date
        model.died_at = metal_archives.date_of_death&.date
        model.gender = metal_archives.gender

        model
      end

      private

      def metal_archives
        @metal_archives ||= MetalArchives::Artist.find!(model.metal_archives_key)
      end
    end
  end
end
