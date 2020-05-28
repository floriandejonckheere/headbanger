# frozen_string_literal: true

module Queries
  module Artists
    class List < ApplicationQuery
      description "List artists alphabetically"
      type Types::GenreType.connection_type

      def resolve
        Artist
          .order(:name)
      end
    end
  end
end
