# frozen_string_literal: true

class Recommend
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      user.recommendations.clear

      user.recommendations = recommendations_for(user)
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def recommendations_for(user, limit = Headbanger.config.recommendation_limit)
    recommendations = Hash.new(0.0)

    # The current user's rated music
    user_likes = user.ratings.liked.pluck(:rateable_type, :rateable_id)
    user_dislikes = user.ratings.disliked.pluck(:rateable_type, :rateable_id)

    # Find all other users
    User.includes(:ratings).where.not(id: user.id).each do |other|
      # The other user's rated music
      other_likes = other.ratings.liked.pluck(:rateable_type, :rateable_id)
      other_dislikes = other.ratings.disliked.pluck(:rateable_type, :rateable_id)

      # Find music both users liked
      common_likes = user_likes & other_likes

      # Find music both users disliked
      common_dislikes = user_dislikes & other_dislikes

      # Calculate weight by dividing number of common ratings
      # by total number of ratings, to rule out noise and edge cases
      likes_weight = common_likes.count.to_f / other_likes.count
      dislikes_weight = common_dislikes.count.to_f / other_dislikes.count

      # Aggregate weight for music the other user rated
      (other_likes - common_likes).each { |rating| recommendations[rating] += likes_weight }
      (other_dislikes - common_dislikes).each { |rating| recommendations[rating] -= dislikes_weight }
    end

    recommendations
      .sort_by(&:last)
      .reverse
      .first(limit)
      .map { |(type, id), _weight| Recommendation.new(user: user, recommended_type: type, recommended_id: id, reason: type.downcase) }
  end
  # rubocop:enable Metrics/AbcSize
end
