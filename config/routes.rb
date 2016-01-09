Rails.application.routes.draw do
  # WebApp will depend on other necessary components
  mount Headbanger::WebApp::Engine => '/'
end
