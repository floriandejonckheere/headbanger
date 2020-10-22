# frozen_string_literal: true

module Queries
  module Users
    class Find < ApplicationQuery
      description "Find user by ID"
      type Types::UserType

      argument :id,
               String,
               required: true

      def resolve(id:)
        User
          .find_by(id: id)
      end
    end
  end
end
