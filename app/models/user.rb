# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :validatable, :confirmable, :trackable

  include GraphqlDevise::Concerns::Model

  ROLES = %w(user admin).freeze

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

  has_many :recommendations,
           dependent: :destroy

  has_many :recommended_artists,
           through: :recommendations,
           source: :recommended,
           source_type: "Artist"

  has_many :recommended_groups,
           through: :recommendations,
           source: :recommended,
           source_type: "Group"

  has_many :recommended_releases,
           through: :recommendations,
           source: :recommended,
           source_type: "Release"

  validates :name,
            presence: true

  validates :country,
            presence: true,
            inclusion: { in: ISO3166::Country.codes }

  validates :role,
            presence: true,
            inclusion: { in: ROLES }

  def user?
    role == "user"
  end

  def admin?
    role == "admin"
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country                :string           not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  name                   :string           not null
#  provider               :string           default("email"), not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("user"), not null
#  sign_in_count          :integer          default(0), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
