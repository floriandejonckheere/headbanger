# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#index'

  devise_for :users

  mount API::Base => '/api'
  # mount Sidekiq::Web => '/sidekiq' if Rails.env == 'development'
end
