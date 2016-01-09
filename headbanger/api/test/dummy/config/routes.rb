Rails.application.routes.draw do

  mount Headbanger::API::Engine => '/api'
end
