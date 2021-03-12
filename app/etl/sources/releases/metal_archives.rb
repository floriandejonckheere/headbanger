# frozen_string_literal: true

module Sources
  module Releases
    class MetalArchives < ETL::Source
      def run(data)
        return data unless data[:metal_archives_key]

        data.merge(metal_archives: ::MetalArchives::Release.new(id: data.fetch(:metal_archives_key)))
      end
    end
  end
end
