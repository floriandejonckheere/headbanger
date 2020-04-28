# frozen_string_literal: true

class ArtistRelease < ApplicationRecord
  self.table_name = "artists_releases"

  belongs_to :artist
  belongs_to :release
end
