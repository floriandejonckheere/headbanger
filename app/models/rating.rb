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

  def likes?
    rating == "like"
  end

  def dislikes?
    rating == "dislike"
  end
end
