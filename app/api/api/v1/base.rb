module API
module V1
  class Base < Grape::API
    version 'v1', using: :path
    format :json

    include GrapeTokenAuth::TokenAuthentication

    # Authenticate all requests
    before do
      authenticate_user!
    end

    rescue_from API::Error::NotFoundError do |e|
      error!(e.message, 404)
    end
    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!(e.message, 400)
    end
    rescue_from :all do |e|
      error!(e.message, 500)
    end

    get '/' do
      {
        :version => :v1
      }
    end

    get '/self' do
      authenticate_user!
      current_user
    end
  end
end
end
