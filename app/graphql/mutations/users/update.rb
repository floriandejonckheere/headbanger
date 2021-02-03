# frozen_string_literal: true

module Mutations
  module Users
    class Update < BaseMutation
      argument :id,
               ID,
               required: true,
               as: :user,
               prepare: ->(id, _context) { User.find(id) }

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

      authorize :user

      def resolve(user:, **attributes)
        if user.update(attributes)
          { user: user, errors: [] }
        else
          { user: nil, errors: user.graphql_errors }
        end
      end
    end
  end
end
