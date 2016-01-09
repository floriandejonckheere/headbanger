Rails.application.routes.draw do

  mount Headbanger::WebApp::Engine => '/'
end
