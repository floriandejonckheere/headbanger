# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Releases
    field :releases, resolver: Queries::Releases::List

    # Genres
    field :genres, resolver: Queries::Genres::List
    field :genre, resolver: Queries::Genres::Find
  end
end
