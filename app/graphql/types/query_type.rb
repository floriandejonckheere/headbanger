# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :releases,
          [ReleaseType],
          null: true do
      description "List releases alphabetically"
    end

    field :genres,
          [GenreType],
          null: true do
      description "List genres alphabetically"
    end

    field :genre,
          GenreType,
          null: true do
      description "Find a genre by id"
      argument :id,
               String,
               required: true
    end

    def releases
      Release.order(:name)
    end

    def genres
      Genre.order(:name)
    end

    def genre(id:)
      Genre.find_by(id: id)
    end
  end
end
