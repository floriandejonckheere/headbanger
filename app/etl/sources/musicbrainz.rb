# frozen_string_literal: true

module Sources
  class MusicBrainz < ETL::Source
    def run(data)
      return data unless data[:musicbrainz_key]

      # TODO: solve this in a proper OOP way
      case data.fetch(:type)
      when "artist", "group"
        data.merge(musicbrainz: ActiveBrainz::Artist.new(data.fetch(:musicbrainz_key)))
      when "release"
        data.merge(musicbrainz: MetalArchives::Release.new(data.fetch(:musicbrainz_key)))
      else
        raise "unknown type: #{data.fetch(:type)}"
      end
    end
  end
end
