require 'api/engine'

Headbanger::WebApp::Engine.routes.draw do
  # API will depend on other necessary components
  mount Headbanger::API::Engine => '/api'
end
