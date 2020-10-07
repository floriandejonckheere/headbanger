# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    # Rating
    field :rate, mutation: Mutations::Music::Rate, authenticate: true

    # Users
    field :update_user, mutation: Mutations::Users::Update, authenticate: true
  end
end
