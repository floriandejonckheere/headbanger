# frozen_string_literal: true

module Pipelines
  class Artist < ETL::Pipeline
    setup do
      # Enhance object with class information
      steps << Steps::Wrap.new("artist")

      # Add Metal Archives source
      steps << Sources::MetalArchives.new

      # TODO: infer musicbrainz_key from metal_archives entity
      # Add MusicBrainz source
      steps << Sources::MusicBrainz.new

      # Add steps
      steps << Steps::Artists::Attributes.new

      # Add sinks
      steps << Sinks::Database.new
    end
  end
end
