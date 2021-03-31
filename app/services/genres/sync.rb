# frozen_string_literal: true

module Genres
  class Sync
    attr_reader :genre, :name

    MAPPING = {
    }.freeze

    def initialize(genre)
      @name = genre.name
      @genre = genre
    end

    def call
      raise ImportError, "no name available" unless genre.name?

      return genre if genre.persisted?

      genre = Genre.find_by(name: MAPPING[name])

      return genre if genre

      raise ImportError, "cannot match genre #{name}"
    end
  end
end
