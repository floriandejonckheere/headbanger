# frozen_string_literal: true

class Recommend
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      user.recommendations.clear

      user.recommendations += service.call(Headbanger.config.recommendation_limit)
    end
  end

  private

  def service
    @service ||= Recommendations::Weighted.new(user)
  end
end
