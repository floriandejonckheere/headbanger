# frozen_string_literal: true

class Recommend
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      recommendations = service.call(Headbanger.config.recommendation_limit)

      user.recommendations.replace(recommendations)
    end
  end

  private

  def service
    @service ||= Recommendations::Weighted.new(user)
  end
end
