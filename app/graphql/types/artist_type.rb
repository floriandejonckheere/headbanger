# frozen_string_literal: true

module Types
  class ArtistType < BaseObject
    implements Interfaces::MusicItem

    description "An artist"

    field :id,
          ID,
          null: false

    field :name,
          String,
          null: false

    field :alt_names,
          [String],
          null: false

    field :country,
          String,
          null: false

    field :description,
          String,
          null: true

    field :gender,
          GenderEnum,
          null: true

    field :born_at,
          GraphQL::Types::ISO8601Date,
          null: true

    field :died_at,
          GraphQL::Types::ISO8601Date,
          null: true

    field :groups,
          [GroupType],
          null: false
  end
end
