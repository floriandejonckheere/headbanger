require 'graph/engine'

Headbanger::API::Engine.routes.draw do
  mount Headbanger::Graph::Engine => '/graph'
end
