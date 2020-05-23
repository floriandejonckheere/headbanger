# frozen_string_literal: true

module Queries
  module Genres
    class List < ApplicationQuery
      description "List genres alphabetically"
      type [Types::GenreType]

      def resolve
        Genre
          .order(:name)
      end
    end
  end
end
