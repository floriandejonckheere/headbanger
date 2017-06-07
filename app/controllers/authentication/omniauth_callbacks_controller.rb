# frozen_string_literal: true

module Authentication
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      create
    end

    def google_oauth2
      create
    end

    def twitter
      create
    end

    private

    def create
      auth_params = request.env['omniauth.auth']
      identity = Identity.where(:provider => auth_params.provider, :uid => auth_params.uid).first
      existing_user = current_user || User.find_by(:email => auth_params.info.email)

      if identity
        sign_in_with_existing_authentication identity
      elsif existing_user
        create_identity_and_sign_in auth_params, existing_user, auth_params.provider
      else
        create_user_and_identity_and_sign_in auth_params, auth_params.provider
      end
    end

    def sign_in_with_existing_authentication(authentication)
      sign_in_and_redirect :user, authentication.user
    end

    def create_identity_and_sign_in(auth_params, user, provider)
      identity = Identity.create :user => user,
                                 :provider => provider,
                                 :uid => auth_params.uid

      user.identities << identity

      sign_in_and_redirect :user, user
    end

    def create_user_and_identity_and_sign_in(auth_params, provider)
      attributes = {
        :name => auth_params.info.first_name || auth_params.info.name || auth_params.info.email,
        :email => auth_params.info.email,
        :password => Devise.friendly_token
      }

      user = User.create attributes
      if user.valid?
        create_identity_and_sign_in auth_params, user, provider
      else
        flash[:error] = user.errors.full_messages.first
        redirect_to new_user_registration_url
      end
    end
  end
end
