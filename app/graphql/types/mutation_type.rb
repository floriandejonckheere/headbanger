# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    # Rating
    field :rate, mutation: Mutations::Music::Rate
  end
end
