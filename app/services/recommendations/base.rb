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
      reasons = %w(artist group genre)

      models
        .sample(Headbanger.config.recommendation_limit)
        .map { |m| Recommendation.new(recommended: m, reason: reasons.sample) }
    end
  end
end
