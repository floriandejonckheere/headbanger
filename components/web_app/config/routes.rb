require 'api/engine'

WebApp::Engine.routes.draw do
  mount API::Engine => '/api'

  root 'landing#index'
end
