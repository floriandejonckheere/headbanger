require 'graph/engine'

API::Engine.routes.draw do
  mount Graph::Engine => '/graph'
end
