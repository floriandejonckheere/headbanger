# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user,
          UserType,
          null: true do
      description "Find a user by name"
      argument :name,
               String,
               required: true
    end

    def user(name:)
      User.find_by("name ILIKE ?", "%#{name}%")
    end
  end
end
