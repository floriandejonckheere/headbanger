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

    field :user,
          UserType,
          null: true do
      description "Find a user by name"
      argument :name,
               String,
               required: true
    end

    def releases
      Release.order(:name)
    end

    def genres
      Genre.order(:name)
    end

    def user(name:)
      User.find_by("name ILIKE ?", "%#{name}%")
    end
  end
end
