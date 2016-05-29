module API
  class Base < Grape::API
    format :json

    include GrapeTokenAuth::MountHelpers
    include GrapeTokenAuth::TokenAuthentication

    mount_registration :to => '/auth', :for => :user
    mount_sessions :to => '/auth', :for => :user
    mount_confirmation :to => '/auth', :for => :user
    mount_token_validation :to => '/auth', :for => :user
    mount_password_reset :to => '/auth', :for => :user

    mount API::V1::Base => '/'

    get '/' do
      {}
    end

    route :any, '*path' do
      error!('Not found', 404)
    end
  end
end
