# frozen_string_literal: true

module Queries
  module Music
    class Search < ApplicationQuery
      description "Find music"
      type [Types::MusicType]

      argument :query,
               String,
               required: true

      def resolve(query:)
        ::Search
          .new(query)
          .call
      end
    end
  end
end
