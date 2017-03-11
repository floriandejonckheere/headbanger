# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#home'

  get 'app' => 'app#home'
  get '/search' => 'app#search'
  get '/discover' => 'app#discover'
  get '/explore' => 'app#explore'

  get '/tos' => 'app#terms_of_service'
  get '/privacy' => 'app#privacy_policy'

  devise_for :users,
                    :controllers => {
                      :omniauth_callbacks => 'users/omniauth_callbacks',
                      :registrations => 'users/registrations'
                    }

  resources :feedbacks, :only => [:create]
end
