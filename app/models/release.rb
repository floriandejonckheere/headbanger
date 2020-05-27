# frozen_string_literal: true

class Release < ApplicationRecord
  include PgSearch::Model
  include Identifiable

  multisearchable against: {
    name: "A",
  }

  has_many :artist_releases,
           dependent: :destroy

  has_many :artists,
           through: :artist_releases

  has_many :group_releases,
           dependent: :destroy

  has_many :groups,
           through: :group_releases

  has_many :ratings,
           as: :rateable,
           dependent: :destroy

  has_many :users,
           through: :ratings

  validates :name,
            presence: true

  validates :released_at,
            presence: true
end

# == Schema Information
#
# Table name: releases
#
#  id                 :uuid             not null, primary key
#  metal_archives_key :string
#  musicbrainz_key    :string
#  name               :string           not null
#  released_at        :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_releases_on_metal_archives_key  (metal_archives_key) UNIQUE
#  index_releases_on_musicbrainz_key     (musicbrainz_key) UNIQUE
#
