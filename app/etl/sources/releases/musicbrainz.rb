# frozen_string_literal: true

module Sources
  module Releases
    class MusicBrainz < ETL::Source
      def run(data)
        return data unless data[:musicbrainz_key]

        data.merge(musicbrainz: MetalArchives::Release.new(data.fetch(:musicbrainz_key)))
      end
    end
  end
end
