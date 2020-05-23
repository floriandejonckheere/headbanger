# frozen_string_literal: true

module Queries
  module Releases
    class List < ApplicationQuery
      description "List releases alphabetically"
      type [Types::ReleaseType]

      def resolve
        Release
          .order(:name)
      end
    end
  end
end
