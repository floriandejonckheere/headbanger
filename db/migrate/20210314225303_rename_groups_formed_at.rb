# frozen_string_literal: true

class RenameGroupsFormedAt < ActiveRecord::Migration[6.1]
  def change
    rename_column :groups, :formed_at, :formed_on
  end
end
