# require 'sidekiq/web'

Rails.application.routes.draw do
  root 'app#landing'

  # TODO: remove when launching
  if Rails.env.development?
    get 'app' => 'app#index'
    get '/search' => 'app#search'
    get '/trending' => 'app#trending'
    get '/discover' => 'app#discover'
    get '/explore' => 'app#explore'

    devise_for :users

    resources :feedbacks, :only => [:create]

    # mount Sidekiq::Web => '/sidekiq'
  end
end
