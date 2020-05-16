# frozen_string_literal: true

module Types
  module Timestamps
    extend ActiveSupport::Concern

    def included
      field :created_at,
            GraphQL::Types::ISO8601DateTime,
            null: false

      field :updated_at,
            GraphQL::Types::ISO8601DateTime,
            null: false
    end
  end
end
