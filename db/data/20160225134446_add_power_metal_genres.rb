class AddPowerMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    # Power Metal
    genre 'Power Metal' do
      # Fusion: Symphonic/Melodic
      # Fusion: Speed
      # Fusion: Traditional Heavy
      # Fusion: Melodic Death
      # Fusion: Neoclassical
      genre 'European Power Metal' do
        genre 'Italian Power Metal'
        genre 'Swedish Power Metal'
        genre 'German Power Metal'
      end

      genre 'US Power Metal' do
        # Fusion: Thrash
      end
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
