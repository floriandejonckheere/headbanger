# frozen_string_literal: true

module Queries
  module Artists
    class List < ApplicationQuery
      description "List artists alphabetically"
      type [Types::GenreType]

      def resolve
        Artist
          .order(:name)
      end
    end
  end
end
