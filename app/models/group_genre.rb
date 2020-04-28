# frozen_string_literal: true

class GroupGenre < ApplicationRecord
  self.table_name = "groups_genres"

  belongs_to :group
  belongs_to :genre
end
