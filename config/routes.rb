# frozen_string_literal: true

# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#home'

  ##
  # User pages
  #
  get '/discover' => 'app#discover'
  get '/queue' => 'app#queue'
  resources :lists

  ##
  # Feedback
  #
  get '/feedback' => 'feedback#new'
  post '/feedback' => 'feedback#create'

  ##
  # Authentication
  #
  devise_for :users,
             :controllers => {
               :omniauth_callbacks => 'authentication/omniauth_callbacks',
               :registrations => 'authentication/registrations'
             }

  get '/tos' => 'authentication/terms#terms_of_service'
  get '/privacy' => 'authentication/terms#privacy_policy'

  ##
  # Resources
  #
  resources :groups, :only => :show
  resources :artists, :only => :show
  resources :releases, :only => :show
end
