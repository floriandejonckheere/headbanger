# frozen_string_literal: true

module Mutations
  module Users
    class Update < BaseMutation
      argument :user_id,
               ID,
               required: true,
               loads: true

      argument :name,
               String,
               required: false

      argument :email,
               String,
               required: false

      argument :password,
               String,
               required: false

      argument :country,
               String,
               required: false

      field :user,
            Types::UserType,
            null: true

      field :errors,
            [Types::ErrorType],
            null: false

      def resolve(user:, **attributes)
        user.update(attributes)

        { user: user, errors: user.graphql_errors }
      end
    end
  end
end
