# frozen_string_literal: true

module Types
  class RecommendationType < Types::BaseObject
    description "A personalized recommendation"

    field :reason,
          ReasonEnum,
          null: false

    field :recommended,
          MusicType,
          null: false
  end
end
