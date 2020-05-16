# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    description "A user"

    field :id,
          ID,
          null: false

    field :name,
          String,
          null: false

    field :email,
          String,
          null: false

    field :country,
          String,
          null: false
  end
end
