# frozen_string_literal: true

class Recommendation < ApplicationRecord
  RECOMMENDATIONS = %w(Artist Group Release).freeze
  REASONS = %w(artist group genre release).freeze

  belongs_to :user

  belongs_to :recommended,
             polymorphic: true

  validates :recommended_type,
            inclusion: { in: RECOMMENDATIONS }

  validates :user_id,
            uniqueness: { scope: [:recommended_id, :recommended_type] }

  validates :reason,
            presence: true,
            inclusion: { in: REASONS }
end

# == Schema Information
#
# Table name: recommendations
#
#  id               :uuid             not null, primary key
#  reason           :string           not null
#  recommended_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recommended_id   :uuid             not null
#  user_id          :uuid             not null
#
# Indexes
#
#  index_recommendations_on_type_and_id              (recommended_type,recommended_id)
#  index_recommendations_on_user_id                  (user_id)
#  index_recommendations_on_user_id_and_id_and_type  (user_id,recommended_id,recommended_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
