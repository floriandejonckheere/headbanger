Rails.application.routes.draw do
  mount WebApp::Engine => '/'
  mount API::Engine => '/api'
  mount Graph::Engine => '/graph'
end
