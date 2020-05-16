# frozen_string_literal: true

module Types
  class ReleaseType < Types::BaseObject
    description "A release"

    field :id,
          ID,
          null: false

    field :name,
          String,
          null: false

    field :released_at,
          GraphQL::Types::ISO8601Date,
          null: false
  end
end
