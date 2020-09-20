# frozen_string_literal: true

module Mutations
  module Auth
    class SignUp < GraphqlDevise::Mutations::SignUp
      argument :name,
               String,
               required: true

      argument :country,
               String,
               required: true

      field :authenticatable,
            Types::UserType,
            null: false
    end
  end
end
