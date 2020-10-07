# frozen_string_literal: true

module Types
  class ErrorType < Types::BaseObject
    description "A user-readable error"

    field :message,
          String,
          null: false

    field :path,
          [String],
          null: true

    field :extensions,
          Types::ExtensionType,
          null: true
  end
end
