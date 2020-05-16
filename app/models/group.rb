# frozen_string_literal: true

class Group < ApplicationRecord
  include Identifiable
  include Refreshable

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

  has_many :ratings,
           as: :rateable,
           dependent: :destroy

  has_many :users,
           through: :ratings

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

# == Schema Information
#
# Table name: groups
#
#  id                 :uuid             not null, primary key
#  alt_names          :jsonb            not null
#  country            :string           not null
#  description        :string
#  formed_at          :date
#  metal_archives_key :string
#  musicbrainz_key    :string
#  name               :string           not null
#  status             :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_groups_on_metal_archives_key  (metal_archives_key) UNIQUE
#  index_groups_on_musicbrainz_key     (musicbrainz_key) UNIQUE
#
