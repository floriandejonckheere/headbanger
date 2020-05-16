# frozen_string_literal: true

class GroupTheme < ApplicationRecord
  self.table_name = "groups_themes"

  belongs_to :group
  belongs_to :theme
end

# == Schema Information
#
# Table name: groups_themes
#
#  group_id :uuid             not null
#  theme_id :uuid             not null
#
# Indexes
#
#  index_groups_themes_on_group_id               (group_id)
#  index_groups_themes_on_group_id_and_theme_id  (group_id,theme_id) UNIQUE
#  index_groups_themes_on_theme_id               (theme_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id) ON DELETE => cascade
#  fk_rails_...  (theme_id => themes.id) ON DELETE => cascade
#
