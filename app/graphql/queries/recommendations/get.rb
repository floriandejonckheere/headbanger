# frozen_string_literal: true

module Queries
  module Recommendations
    class Get < ApplicationQuery
      description "Get recommendations by User ID"
      type [Types::RecommendationType]

      argument :user_id,
               String,
               required: true

      def resolve(user_id:)
        User
          .find_by(id: user_id)
          &.recommendations || []
      end
    end
  end
end
