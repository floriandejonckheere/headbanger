# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    description "A user"

    global_id_field :id

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
