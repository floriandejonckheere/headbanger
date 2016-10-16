# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#index'

  # Custom Devise routes
  scope :users do
    # Sessions
    post '/sign_in', :to => 'devise/sessions#create', :as => 'user_session'
    delete '/sign_out', :to => 'devise/sessions#destroy', :as => 'destroy_user_session'

    # Registrations
    post '/', :to => 'devise/registrations#create', :as => 'user_registration'
    delete '/', :to => 'devise/registrations#destroy'
  end

  # mount Sidekiq::Web => '/sidekiq' if Rails.env == 'development'
end
