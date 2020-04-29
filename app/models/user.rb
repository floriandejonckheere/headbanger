# frozen_string_literal: true

class User < ApplicationRecord
  has_many :ratings,
           dependent: :destroy

  has_many :rated_artists,
           through: :ratings,
           source: :rateable,
           source_type: "Artist"

  has_many :rated_groups,
           through: :ratings,
           source: :rateable,
           source_type: "Group"

  has_many :rated_releases,
           through: :ratings,
           source: :rateable,
           source_type: "Release"

  validates :name,
            presence: true

  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :country,
            inclusion: { in: ISO3166::Country.codes },
            allow_nil: true
end
