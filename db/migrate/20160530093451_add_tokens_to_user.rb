class AddTokensToUser < ActiveRecord::Migration
  def change
    add_column :users, :tokens, :string
  end
end
