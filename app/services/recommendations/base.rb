# frozen_string_literal: true

module Recommendations
  class Base
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      # TODO: actual implementation

      models = Artist.all + Group.all + Release.all

      models
        .sample(Headbanger.config.recommendation_limit)
        .map { |m| Recommendation.new(recommended: m, reason: %w(artist group genre).sample) }
    end
  end
end
