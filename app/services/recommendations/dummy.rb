# frozen_string_literal: true

module Recommendations
  class Dummy < Base
    def call(number)
      models = Artist.all + Group.all + Release.all
      reasons = %w(artist group genre)

      models
        .sample(number)
        .map { |m| Recommendation.new(recommended: m, reason: reasons.sample) }
    end
  end
end
