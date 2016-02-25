class AddFusionMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    # Fusion genres
    genre 'Symphonic Metal'
    genre 'Melodic Metal'
    genre 'Ambient Metal'
    genre 'Dark Metal'
    genre 'Epic Metal'
    genre 'Speed Metal'
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
