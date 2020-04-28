# frozen_string_literal: true

class GroupTheme < ApplicationRecord
  self.table_name = "groups_themes"

  belongs_to :group
  belongs_to :theme
end
