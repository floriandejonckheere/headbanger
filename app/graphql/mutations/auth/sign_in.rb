# frozen_string_literal: true

module Mutations
  module Auth
    class SignIn < GraphqlDevise::Mutations::Login
      field :authenticatable,
            Types::UserType,
            null: false
    end
  end
end
