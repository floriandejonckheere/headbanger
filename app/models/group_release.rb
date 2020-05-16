# frozen_string_literal: true

class GroupRelease < ApplicationRecord
  self.table_name = "groups_releases"

  belongs_to :group
  belongs_to :release
end

# == Schema Information
#
# Table name: groups_releases
#
#  group_id   :uuid             not null
#  release_id :uuid             not null
#
# Indexes
#
#  index_groups_releases_on_group_id                 (group_id)
#  index_groups_releases_on_group_id_and_release_id  (group_id,release_id) UNIQUE
#  index_groups_releases_on_release_id               (release_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id) ON DELETE => cascade
#  fk_rails_...  (release_id => releases.id) ON DELETE => cascade
#
