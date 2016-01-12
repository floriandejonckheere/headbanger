require 'graph/engine'

require_relative '../app/api/api/base'

API::Engine.routes.draw do
  # API
  mount API::Base => '/'

  mount Graph::Engine => '/graph'
end
