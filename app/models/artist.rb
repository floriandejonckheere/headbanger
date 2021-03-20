# frozen_string_literal: true

class Artist < ApplicationRecord
  include PgSearch::Model
  include Identifiable
  include Syncable

  GENDERS = %w(male female other unknown).freeze

  multisearchable against: %w(name alt_names description)

  after_initialize :set_defaults

  has_many :artist_groups,
           dependent: :destroy

  has_many :groups,
           through: :artist_groups

  has_many :artist_releases,
           dependent: :destroy

  has_many :releases,
           through: :artist_releases

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

  validates :country,
            inclusion: { in: ISO3166::Country.codes },
            allow_nil: true

  validates :gender,
            presence: true,
            inclusion: { in: GENDERS }

  def set_defaults
    self.gender ||= "unknown"
  end
end

# == Schema Information
#
# Table name: artists
#
#  id                 :uuid             not null, primary key
#  alt_names          :jsonb            not null
#  born_on            :date
#  country            :string           not null
#  description        :string
#  died_on            :date
#  gender             :string
#  metal_archives_key :string
#  musicbrainz_key    :string
#  name               :string           not null
#  synced_at          :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_artists_on_metal_archives_key  (metal_archives_key) UNIQUE
#  index_artists_on_musicbrainz_key     (musicbrainz_key) UNIQUE
#
