# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#index'

  devise_for :users

  # mount Sidekiq::Web => '/sidekiq' if Rails.env == 'development'
end
