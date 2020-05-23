# frozen_string_literal: true

module Queries
  module Genres
    class Find < ApplicationQuery
      description "Find genre by ID"
      type Types::GenreType

      argument :id,
               String,
               required: true

      def resolve(id:)
        Genre
          .find_by(id: id)
      end
    end
  end
end
