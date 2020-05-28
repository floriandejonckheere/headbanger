# frozen_string_literal: true

module Queries
  module Music
    class Search < ApplicationQuery
      description "Find music"
      type Types::MusicType.connection_type

      argument :query,
               String,
               required: true

      def resolve(query:)
        return [] if query.length < 3

        ::Search
          .new(query)
          .call
      end
    end
  end
end
