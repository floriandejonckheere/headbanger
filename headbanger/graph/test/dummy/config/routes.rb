Rails.application.routes.draw do

  mount Headbanger::Graph::Engine => '/graph'
end
