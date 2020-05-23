# frozen_string_literal: true

class CreateRecommendations < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendations, id: :uuid do |t|
      t.references :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :recommended,
                   null: false,
                   type: :uuid,
                   polymorphic: true,
                   index: { name: "index_recommendations_on_type_and_id" }

      t.string :reason, null: false

      t.timestamps
    end

    add_index :recommendations,
              [:user_id, :recommended_id, :recommended_type],
              unique: true,
              name: "index_recommendations_on_user_id_and_id_and_type"
  end
end
