# frozen_string_literal: true

class GroupRelease < ApplicationRecord
  self.table_name = "groups_releases"

  belongs_to :group
  belongs_to :release
end
