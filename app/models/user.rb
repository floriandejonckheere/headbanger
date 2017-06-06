# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :trackable,
         :timeoutable,
         :validatable,
         :omniauthable, :omniauth_providers => %i[facebook google_oauth2 twitter]

  has_many :authentications,
           :class_name => 'UserAuthentication',
           :dependent => :destroy
  has_many :authentication_providers,
           :through => :authentications

  validates :email,
            :presence => true

  def display_name
    name || email
  end

  class << self
    def create_from_omniauth(auth)
      attributes = {
        :name => auth.info.first_name || auth.info.name || auth.info.email,
        :email => auth.info.email,
        :password => Devise.friendly_token
      }

      create attributes
    end
  end
end
