# frozen_string_literal: true

class AddDescriptionToReleases < ActiveRecord::Migration[6.1]
  def change
    add_column :releases, :description, :string
  end
end
