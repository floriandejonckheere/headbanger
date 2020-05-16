# frozen_string_literal: true

class ArtistRelease < ApplicationRecord
  self.table_name = "artists_releases"

  belongs_to :artist
  belongs_to :release
end

# == Schema Information
#
# Table name: artists_releases
#
#  artist_id  :uuid             not null
#  release_id :uuid             not null
#
# Indexes
#
#  index_artists_releases_on_artist_id                 (artist_id)
#  index_artists_releases_on_artist_id_and_release_id  (artist_id,release_id) UNIQUE
#  index_artists_releases_on_release_id                (release_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id) ON DELETE => cascade
#  fk_rails_...  (release_id => releases.id) ON DELETE => cascade
#
