class AddExtremeMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    # Extreme
    genre 'Extreme Metal' do
      genre 'Thrash Metal' do
        # Fusion: Black
        genre 'Crossover Thrash Metal'
        genre 'Teutonic Thrash Metal'
        genre 'Groove Metal'
      end

      genre 'Death Metal' do
        # Fusion: Melodic
        # Fusion: Black
        # Fusion: Doom
        genre 'Technical Death Metal'
        genre 'Deathcore'
        genre 'Death \'n\' Roll'
      end

      genre 'Doom Metal' do
        # Fusion: Symphonic/Melodic
        # Fusion: Death
        # Fusion: Black
        # Fusion: Epic
        # Fusion: Traditional Heavy
        genre 'Drone Metal'
        genre 'Funeral Metal'
        genre 'Sludge Metal'
        genre 'Stoner Metal'
      end

      genre 'Black Metal' do
        # Fusion: Ambient
        # Fusion: Symphonic/Melodic
        # Fusion: Death
        # Fusion: Doom
        # Fusion: Pagan
        # Fusion: Viking
        genre 'Blackgaze'
        genre 'War Metal'
      end

      genre 'Grindcore' do
        genre 'Goregrind'
        genre 'Deathgrind'
        genre 'Pornogrind'
      end
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
