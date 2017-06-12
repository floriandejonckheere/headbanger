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

  resources :users, :only => :show do
    member do
      post '/follow' => 'users#follow'
      post '/unfollow' => 'users#unfollow'
    end
  end

  resources :lists

  ##
  # Data pages
  #
  resources :groups, :only => :show do
    member do
      post '/follow' => 'groups#follow'
      post '/unfollow' => 'groups#unfollow'

      post '/queue' => 'groups#queue'
      post '/unqueue' => 'groups#unqueue'
    end
  end

  resources :artists, :only => :show do
    member do
      post '/follow' => 'artists#follow'
      post '/unfollow' => 'artists#unfollow'

      post '/queue' => 'artists#queue'
      post '/unqueue' => 'artists#unqueue'
    end
  end

  resources :releases, :only => :show

  ##
  # General
  #
  get '/feedback' => 'feedback#new'
  post '/feedback' => 'feedback#create'

  get '/tos' => 'authentication/terms#terms_of_service'
  get '/privacy' => 'authentication/terms#privacy_policy'
end
