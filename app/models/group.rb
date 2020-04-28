# frozen_string_literal: true

class Group < ApplicationRecord
  include Identifiable
  include Refreshable
  include Rateable

  STATUSES = %w(active split_up on_hold changed_name disputed unknown).freeze

  has_many :artist_groups,
           dependent: :destroy

  has_many :artists,
           through: :artist_groups

  has_many :group_releases,
           dependent: :destroy

  has_many :releases,
           through: :group_releases

  has_many :group_themes,
           dependent: :destroy

  has_many :themes,
           through: :group_themes

  has_many :group_genres,
           dependent: :destroy

  has_many :genres,
           through: :group_genres

  validates :name,
            presence: true

  validates :alt_names,
            presence: true,
            allow_blank: true

  validates :description,
            presence: true

  validates :formed_at,
            presence: true

  validates :status,
            presence: true,
            inclusion: { in: STATUSES }

  validates :country,
            inclusion: { in: ISO3166::Country.codes },
            allow_nil: true
end
