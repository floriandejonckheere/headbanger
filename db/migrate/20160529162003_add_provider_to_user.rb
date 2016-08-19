class AddProviderToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string, :null => false, :default => 'email'
  end
end
