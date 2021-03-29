# frozen_string_literal: true

class Theme < ApplicationRecord
  has_many :group_themes,
           dependent: :destroy

  has_many :groups,
           through: :group_themes

  validates :name,
            presence: true,
            uniqueness: true

  def description
    Theme.description_for(name)
  end

  def self.name_for(description)
    description
      .parameterize(separator: "_")
  end

  def self.description_for(name)
    name&.titleize
  end
end

# == Schema Information
#
# Table name: themes
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_themes_on_name  (name) UNIQUE
#
