Rails.application.routes.draw do
  devise_for :users, :class_name => 'User'

  mount API::Base => '/'

  root 'landing#index'

  get '/app', :to => 'app#index'
end
