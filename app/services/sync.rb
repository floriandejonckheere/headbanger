# frozen_string_literal: true

class Sync
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def call
    return if model.synced_at > Headbanger.config.data_expires_in.ago

    Artists::Import.new(metal_archives_key: model.metal_archives_key, musicbrainz_key: model.musicbrainz_key)
  end
end
