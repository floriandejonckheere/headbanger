# frozen_string_literal: true

class LoosenSyncedAtConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column_null :artists, :synced_at, from: false, to: true
    change_column_default :artists, :synced_at, from: -> { "CURRENT_TIMESTAMP" }, to: nil

    change_column_null :groups, :synced_at, from: false, to: true
    change_column_default :groups, :synced_at, from: -> { "CURRENT_TIMESTAMP" }, to: nil

    change_column_null :releases, :synced_at, true
    change_column_default :releases, :synced_at, from: -> { "CURRENT_TIMESTAMP" }, to: nil
  end
end
