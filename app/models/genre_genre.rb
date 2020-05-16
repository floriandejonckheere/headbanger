# frozen_string_literal: true

class GenreGenre < ApplicationRecord
  self.table_name = "genres_genres"

  belongs_to :supergenre,
             class_name: "Genre"

  belongs_to :subgenre,
             class_name: "Genre"
end

# == Schema Information
#
# Table name: genres_genres
#
#  subgenre_id   :uuid             not null
#  supergenre_id :uuid             not null
#
# Indexes
#
#  index_genres_genres_on_subgenre_id    (subgenre_id)
#  index_genres_genres_on_supergenre_id  (supergenre_id)
#
# Foreign Keys
#
#  fk_rails_...  (subgenre_id => genres.id) ON DELETE => cascade
#  fk_rails_...  (supergenre_id => genres.id) ON DELETE => cascade
#
