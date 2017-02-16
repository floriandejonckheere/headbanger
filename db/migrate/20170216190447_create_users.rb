class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|

      t.timestamps

      t.string :name
    end
  end
end
