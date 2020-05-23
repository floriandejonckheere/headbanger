# frozen_string_literal: true

class Recommend
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      recommendations = service.call

      user.recommendations.replace(recommendations)
    end
  end

  private

  def service
    @service ||= Recommendations::Base.new(user)
  end
end
