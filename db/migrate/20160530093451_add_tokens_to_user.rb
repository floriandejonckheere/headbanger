class AddTokensToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tokens, :string
  end
end
