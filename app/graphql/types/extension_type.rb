# frozen_string_literal: true

module Types
  class ExtensionType < Types::BaseObject
    description "An error extension"

    field :code,
          String,
          null: false
  end
end
