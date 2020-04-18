# frozen_string_literal: true

module Graph
  class GenreBuilder < ApplicationBuilder
    def initialize(name:)
      super(name: genre_for(name))
    end

    def associations
      # Guess genre relationships
      Genre.flat_taxonomy.each do |genre|
        model.supergenres << Genre.find_by!(name: genre) if /#{genre}/.match?(model.name)
      end
    end

    private

    def genre_for(name)
      name
        .underscore
        .gsub(/ +/, "_")
        .tr("/", "_")
        .gsub(/_?metal/, "")
    end
  end
end
