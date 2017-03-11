# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#discover'

  get '/tos' => 'app#terms_of_service'
  get '/privacy' => 'app#privacy_policy'

  get '/feedback' => 'feedback#new'
  post '/feedback' => 'feedback#create'

  devise_for :users,
                    :controllers => {
                      :omniauth_callbacks => 'users/omniauth_callbacks',
                      :registrations => 'users/registrations'
                    }
end
