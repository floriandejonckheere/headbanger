# frozen_string_literal: true

module Mutations
  module Music
    class Rate < BaseMutation
      null true

      argument :type,
               String,
               required: true

      argument :id,
               ID,
               required: true

      argument :rating,
               String,
               required: false

      field :rateable,
            Types::MusicType,
            null: true

      field :errors,
            [String],
            null: false

      def resolve(type:, id:, rating: nil)
        # FIXME: fetch user from session
        user = User.first
        rateable = type.safe_constantize.find(id)

        user_rating = Rating.find_or_initialize_by(user: user, rateable: rateable)

        if rating.nil?
          user_rating.destroy!
        else
          user_rating.rating = rating
          user_rating.save!
        end

        {
          rateable: rateable,
          errors: [],
        }
      rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
        {
          rateable: nil,
          errors: [e.message],
        }
      end
    end
  end
end
