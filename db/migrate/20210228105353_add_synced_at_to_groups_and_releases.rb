# frozen_string_literal: true

class AddSyncedAtToGroupsAndReleases < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :synced_at, :timestamp, null: false, default: -> { "CURRENT_TIMESTAMP" }
    add_column :releases, :synced_at, :timestamp, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
