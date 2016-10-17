# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#index'

  get '/search' => 'app#search'
  get '/trending' => 'app#trending'
  get '/discover' => 'app#discover'
  get '/explore' => 'app#explore'

  devise_for :users

  # mount Sidekiq::Web => '/sidekiq' if Rails.env == 'development'
end
