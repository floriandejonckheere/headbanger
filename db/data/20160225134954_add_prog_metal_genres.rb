class AddProgMetalGenres < ActiveRecord::Migration
  require_relative 'data_migration_helper'

  def self.up
    genre 'Progressive Metal' do
      genre 'Djent Metal'
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
