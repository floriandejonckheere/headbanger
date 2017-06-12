# frozen_string_literal: true

# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#home'

  ##
  # Authentication
  #
  devise_for :users,
             :controllers => {
               :omniauth_callbacks => 'authentication/omniauth_callbacks',
               :registrations => 'authentication/registrations'
             }

  ##
  # User pages
  #
  get '/discover' => 'app#discover'
  get '/queue' => 'app#queue'
  resources :users, :only => :show
  resources :lists

  ##
  # Application pages
  #
  get '/feedback' => 'feedback#new'
  post '/feedback' => 'feedback#create'

  get '/tos' => 'authentication/terms#terms_of_service'
  get '/privacy' => 'authentication/terms#privacy_policy'

  ##
  # Data pages
  #
  resources :groups, :only => :show
  resources :artists, :only => :show
  resources :releases, :only => :show
end
