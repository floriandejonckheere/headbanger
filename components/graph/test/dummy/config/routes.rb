Rails.application.routes.draw do

  mount Graph::Engine => "/graph"
end
