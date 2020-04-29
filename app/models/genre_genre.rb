# frozen_string_literal: true

class GenreGenre < ApplicationRecord
  self.table_name = "genres_genres"

  belongs_to :supergenre,
             class_name: "Genre"

  belongs_to :subgenre,
             class_name: "Genre"
end
