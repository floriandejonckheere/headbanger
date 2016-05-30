class AddProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, :null => false, :default => 'email'
  end
end
