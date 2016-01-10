Rails.application.routes.draw do

  mount WebApp::Engine => "/web_app"
end
