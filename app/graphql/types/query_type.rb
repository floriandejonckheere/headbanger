# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Releases
    field :list_releases, resolver: Queries::Releases::List

    # Genres
    field :list_genres, resolver: Queries::Genres::List
    field :find_genre, resolver: Queries::Genres::Find

    # Recommendations
    field :get_recommendations, resolver: Queries::Recommendations::Get
  end
end
