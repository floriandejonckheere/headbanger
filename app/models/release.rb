# frozen_string_literal: true

class Release < ApplicationRecord
  include Identifiable
  include Refreshable

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
