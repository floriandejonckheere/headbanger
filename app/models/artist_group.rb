# frozen_string_literal: true

class ArtistGroup < ApplicationRecord
  self.table_name = "artists_groups"

  belongs_to :artist
  belongs_to :group
end

# == Schema Information
#
# Table name: artists_groups
#
#  artist_id :uuid             not null
#  group_id  :uuid             not null
#
# Indexes
#
#  index_artists_groups_on_artist_id               (artist_id)
#  index_artists_groups_on_artist_id_and_group_id  (artist_id,group_id) UNIQUE
#  index_artists_groups_on_group_id                (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id) ON DELETE => cascade
#  fk_rails_...  (group_id => groups.id) ON DELETE => cascade
#
