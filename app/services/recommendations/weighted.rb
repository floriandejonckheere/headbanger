# frozen_string_literal: true

module Recommendations
  ##
  # Simple weighted collaborative filtering algorithm
  class Weighted < Base
    def call(number)
      recommendations = Hash.new(0.0)

      # The current user's rated music
      self_ratings = user.ratings.liked.pluck(:rateable_type, :rateable_id)

      # Find all other users
      User.includes(:ratings).each do |other|
        next if user.id == other.id

        # The other user's rated music
        other_ratings = other.ratings.liked.pluck(:rateable_type, :rateable_id)

        # Find music both users liked
        common = self_ratings & other_ratings

        # Calculate weight by dividing number of common ratings
        # by total number of ratings, to rule out noise and edge cases
        weight = common.count.to_f / other_ratings.count

        # TODO: subtract dislikes

        # Aggregate weight for music the other user rated
        (other_ratings - common).each { |rating| recommendations[rating] += weight }
      end

      recommendations
        .sort_by(&:last)
        .reverse
        .first(number)
        .map { |(type, id), _weight| Recommendation.new(user: user, recommended_type: type, recommended_id: id, reason: type.downcase) }
    end
  end
end
