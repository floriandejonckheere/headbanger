# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Artists
    field :list_artists, resolver: Queries::Artists::List, authenticate: true
    field :find_artist, resolver: Queries::Artists::Find, authenticate: true

    # Releases
    field :list_releases, resolver: Queries::Releases::List, authenticate: true

    # Genres
    field :list_genres, resolver: Queries::Genres::List, authenticate: true
    field :find_genre, resolver: Queries::Genres::Find, authenticate: true

    # Recommendations
    field :get_recommendations, resolver: Queries::Recommendations::Get, authenticate: true

    # Search
    field :search, resolver: Queries::Music::Search, authenticate: true
  end
end
