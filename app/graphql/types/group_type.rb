# frozen_string_literal: true

module Types
  class GroupType < Types::BaseObject
    description "A group"

    field :id,
          ID,
          null: false

    field :name,
          String,
          null: false

    field :alt_names,
          [String],
          null: false

    field :description,
          String,
          null: true

    field :status,
          StatusEnum,
          null: true

    field :formed_at,
          GraphQL::Types::ISO8601Date,
          null: true
  end
end