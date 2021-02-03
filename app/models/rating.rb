# frozen_string_literal: true

class Rating < ApplicationRecord
  RATEABLES = %w(Artist Group Release).freeze
  RATINGS = %w(like dislike).freeze

  belongs_to :user

  belongs_to :rateable,
             polymorphic: true

  validates :rating,
            presence: true,
            inclusion: { in: RATINGS }

  validates :rateable_type,
            inclusion: { in: RATEABLES }

  validates :user_id,
            uniqueness: { scope: [:rateable_id, :rateable_type] }

  def liked?
    rating == "like"
  end

  def disliked?
    rating == "dislike"
  end

  def self.liked
    where(rating: :like)
  end

  def self.disliked
    where(rating: :dislike)
  end
end

# == Schema Information
#
# Table name: ratings
#
#  id            :uuid             not null, primary key
#  rateable_type :string           not null
#  rating        :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rateable_id   :uuid             not null
#  user_id       :uuid             not null
#
# Indexes
#
#  index_ratings_on_rateable_type_and_rateable_id              (rateable_type,rateable_id)
#  index_ratings_on_user_id                                    (user_id)
#  index_ratings_on_user_id_and_rateable_id_and_rateable_type  (user_id,rateable_id,rateable_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
