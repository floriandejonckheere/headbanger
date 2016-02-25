class AddFolkMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    genre 'Folk Metal' do
      genre 'Celtic Metal'
      genre 'Medieval Metal'
      genre 'Pagan Metal'
      genre 'Pirate Metal'
      genre 'Viking Metal'
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
