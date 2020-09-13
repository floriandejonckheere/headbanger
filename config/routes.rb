# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "application#index"

  # GraphQL API
  post "/graphql", to: "graphql#execute"

  next if Rails.env.development?

  # GraphQL API UI
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
end

# == Route Map
#
#  Prefix Verb URI Pattern        Controller#Action
#    root GET  /                  application#index
# graphql POST /graphql(.:format) graphql#execute
