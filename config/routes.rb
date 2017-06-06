# frozen_string_literal: true

# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#discover'

  get '/queue' => 'app#queue'

  get '/tos' => 'app#terms_of_service'
  get '/privacy' => 'app#privacy_policy'

  get '/feedback' => 'feedback#new'
  post '/feedback' => 'feedback#create'

  devise_for :users,
             :controllers => {
               :omniauth_callbacks => 'users/omniauth_callbacks',
               :registrations => 'users/registrations'
             }

  # Resources
  resources :groups, :only => :show
  resources :artists, :only => :show
  resources :releases, :only => :show
end
