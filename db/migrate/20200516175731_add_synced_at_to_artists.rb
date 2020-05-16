# frozen_string_literal: true

class AddSyncedAtToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :synced_at, :timestamp, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
