# frozen_string_literal: true

class GroupGenre < ApplicationRecord
  self.table_name = "groups_genres"

  belongs_to :group
  belongs_to :genre
end

# == Schema Information
#
# Table name: groups_genres
#
#  genre_id :uuid             not null
#  group_id :uuid             not null
#
# Indexes
#
#  index_groups_genres_on_genre_id               (genre_id)
#  index_groups_genres_on_group_id               (group_id)
#  index_groups_genres_on_group_id_and_genre_id  (group_id,genre_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id) ON DELETE => cascade
#  fk_rails_...  (group_id => groups.id) ON DELETE => cascade
#
