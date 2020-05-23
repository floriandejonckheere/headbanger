# frozen_string_literal: true

module Types
  class GenreType < Types::BaseObject
    description "A musical genre"

    field :id,
          ID,
          null: false

    field :name,
          String,
          null: false

    field :description,
          String,
          null: false

    field :groups,
          [GroupType],
          null: false
  end
end
