require 'grape'

module API
module V1
  class Base < ::Grape::API
    version 'v1', using: :path
    format :json

    rescue_from API::Error::NotFoundError do |e|
      error!(e.message, 404)
    end
    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!(e.message, 400)
    end
    rescue_from :all do |e|
      error!(e.message, 500)
    end

    get :version do
      'v1'
    end

    route :any, '*path' do
      error!('Not Found', 404)
    end
  end
end
end
