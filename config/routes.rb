require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :class_name => 'User'

  mount API::Base => '/api'
  mount Sidekiq::Web => '/sidekiq' if Rails.env == 'development'

  resources :users

  root 'app#index'
end
