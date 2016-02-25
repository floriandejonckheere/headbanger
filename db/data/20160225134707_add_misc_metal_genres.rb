class AddMiscMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    genre 'Avant-garde Metal'
    genre 'Christian Metal' do
      # Fusion: Black => Unblack
    end
    genre 'Glam Metal'
    genre 'Gothic Metal'
    genre 'Industrial Metal' do
      # Fusion: Black
      # Fusion: Death
      # Fusion: Thrash
    end
    genre 'Latin Metal'
    genre 'Neoclassical Metal'
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
