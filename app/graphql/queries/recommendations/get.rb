# frozen_string_literal: true

module Queries
  module Recommendations
    class Get < ApplicationQuery
      description "Get recommendations"
      type [Types::RecommendationType]

      def resolve
        # FIXME: fetch user from session
        User
          .first
          &.recommendations || []
      end
    end
  end
end
