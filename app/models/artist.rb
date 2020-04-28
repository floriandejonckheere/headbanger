# frozen_string_literal: true

class Artist < ApplicationRecord
  include Identifiable
  include Refreshable
  include Rateable

  GENDERS = %w(male female other unknown).freeze

  has_many :artist_groups,
           dependent: :destroy

  has_many :groups,
           through: :artist_groups

  has_many :artist_releases,
           dependent: :destroy

  has_many :releases,
           through: :artist_releases

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
end
