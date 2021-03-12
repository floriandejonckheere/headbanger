# frozen_string_literal: true

module Pipelines
  class Artist < ETL::Pipeline
    step do
      # Enhance object with type information
      Steps::Type.new("artist")
    end

    step do
      # Add Metal Archives source
      Sources::Artists::MetalArchives.new
    end

    step do
      # TODO: infer musicbrainz_key from metal_archives entity
      # Add MusicBrainz source
      Sources::Artists::MusicBrainz.new
    end

    step do
      # Add steps
      Steps::Artists::Attributes.new
    end

    step do
      # Add sinks
      Sinks::Database.new
    end
  end
end
