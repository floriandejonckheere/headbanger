# frozen_string_literal: true

class RecommendationJob < ApplicationJob
  def perform
    User.find_each do |user|
      Recommend.new(user).call
    end
  end
end
