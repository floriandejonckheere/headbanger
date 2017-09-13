# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'

  ##
  # User resources
  #
  jsonapi_resources :users, :only => %i[show]
  jsonapi_resources :lists
  # jsonapi_resource :queue
  jsonapi_resources :search, :only => %i[create]

  ##
  # Data pages
  #
  jsonapi_resources :groups
  jsonapi_resources :artists
  jsonapi_resources :releases
end
