# frozen_string_literal: true

class RenameArtistsBornAtDiedAt < ActiveRecord::Migration[6.1]
  def change
    rename_column :artists, :born_at, :born_on
    rename_column :artists, :died_at, :died_on
  end
end
