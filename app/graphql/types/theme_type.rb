# frozen_string_literal: true

module Types
  class ThemeType < Types::BaseObject
    description "A lyrical theme"

    field :id,
          ID,
          null: false

    field :name,
          String,
          null: false

    field :description,
          String,
          null: false
  end
end
