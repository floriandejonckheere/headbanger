class User < ApplicationRecord
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :trackable,
          :timeoutable,
          :validatable,
          :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  has_many :authentications,
                          :class_name => 'UserAuthentication',
                          :dependent => :destroy

  validates :email,
              :presence => true

  def display_name
    self.name || self.email
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
