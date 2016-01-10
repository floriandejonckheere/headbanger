Rails.application.routes.draw do

  mount API::Engine => "/api"
end
