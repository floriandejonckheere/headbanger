# frozen_string_literal: true

module Sources
  class MetalArchives < ETL::Source
    def run(data)
      return data unless data[:metal_archives_key]

      # TODO: solve this in a proper OOP way
      case data.fetch(:type)
      when "artist"
        data.merge(metal_archives: ::MetalArchives::Artist.new(id: data.fetch(:metal_archives_key)))
      when "group"
        data.merge(metal_archives: ::MetalArchives::Band.new(id: data.fetch(:metal_archives_key)))
      when "release"
        data.merge(metal_archives: ::MetalArchives::Release.new(id: data.fetch(:metal_archives_key)))
      else
        raise "unknown type: #{data.fetch(:type)}"
      end
    end
  end
end
