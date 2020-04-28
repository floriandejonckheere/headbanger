# frozen_string_literal: true

class ArtistGroup < ApplicationRecord
  self.table_name = "artists_groups"

  belongs_to :artist
  belongs_to :group
end
