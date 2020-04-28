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

  class << self
    def name_for(description)
      description
        .parameterize(separator: "_")
    end

    def description_for(name)
      name&.titleize
    end
  end
end
