module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        # Require email permission
        if request.env["omniauth.auth"].info.email.blank?
          redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
        else
          # Removing extra as it can overflow some session stores
          session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra)
          # TODO: flash error message
          redirect_to new_user_registration_url
        end
      end
    end

    def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      else
        # Removing extra as it can overflow some session stores
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
        # TODO: flash error message
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
