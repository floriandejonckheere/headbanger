# require 'sidekiq/web'

Rails.application.routes.draw do
  mount API::Base => '/api'
  # mount Sidekiq::Web => '/sidekiq' if Rails.env == 'development'

  root 'app#index'
end
