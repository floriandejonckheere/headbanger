# frozen_string_literal: true

Rails.application.routes.draw do
  # GraphQL API UI
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?

  namespace :api do
    get "/", to: "application#index"
  end

  # GraphQL API
  post "/graphql", to: "graphql#execute"
end
