# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get "/", to: "application#index"
  end

  # GraphQL API
  post "/graphql", to: "graphql#execute"
end
