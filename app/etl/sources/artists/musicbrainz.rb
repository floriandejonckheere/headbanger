# frozen_string_literal: true

module Sources
  module Artists
    class MusicBrainz < ETL::Source
      def run(data)
        return data unless data[:musicbrainz_key]

        data.merge(musicbrainz: ActiveBrainz::Artist.new(data.fetch(:musicbrainz_key)))
      end
    end
  end
end
