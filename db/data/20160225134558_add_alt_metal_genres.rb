class AddAltMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    genre 'Alternative Metal' do
      genre 'Funk Metal'
      genre 'Nu Metal'
      genre 'Rap Metal'
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
