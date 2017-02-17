class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :confirmable,
          :trackable,
          :timeoutable,
          :validatable,
          :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :email,
              :presence => true

  def display_name
    self.name || self.email
  end

  class << self
    def from_omniauth(auth)
      where(:provider => auth.provider, :uid => auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid

        user.name = auth.info.first_name || auth.info.name
        user.email = auth.info.email if auth.info.email

        # Dummy password
        user.password = Devise.friendly_token[0,20]

        user.skip_confirmation!
      end
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
