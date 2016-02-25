class AddTraditionalMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    genre 'Traditional Heavy Metal' do
      # Fusion: Glam
      # Fusion: Dark
      genre 'New Wave of British Heavy Metal'
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
