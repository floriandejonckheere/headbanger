# frozen_string_literal: true

# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#index'

  ##
  # User resources
  #

  jsonapi_resources :users, :only => %i[show]
  jsonapi_resources :lists
  # jsonapi_resource :queue

  ##
  # Data pages
  #
  jsonapi_resources :groups
  jsonapi_resources :artists
  jsonapi_resources :releases
end
