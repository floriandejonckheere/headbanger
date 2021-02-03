# frozen_string_literal: true

module Mutations
  module Users
    class Delete < BaseMutation
      argument :id,
               ID,
               required: true,
               as: :user,
               prepare: ->(id, _context) { User.find(id) }

      field :errors,
            [Types::ErrorType],
            null: false

      authorize :user

      def resolve(user:, **_attributes)
        if user.destroy
          { errors: [] }
        else
          { errors: user.graphql_errors }
        end
      end
    end
  end
end
