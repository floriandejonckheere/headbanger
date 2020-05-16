# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user,
          UserType,
          null: true do
      description "Find a user by ID"
      argument :id,
               ID,
               required: true
    end

    def user(id:)
      User.find(id)
    end
  end
end
