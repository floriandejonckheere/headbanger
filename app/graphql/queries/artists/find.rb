# frozen_string_literal: true

module Queries
  module Artists
    class Find < ApplicationQuery
      description "Find artist by ID"
      type Types::ArtistType

      argument :id,
               String,
               required: true

      def resolve(id:)
        Artist
          .find_by(id: id)
      end
    end
  end
end
