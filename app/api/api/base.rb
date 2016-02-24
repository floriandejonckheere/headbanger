module API
  class Base < Grape::API
    format :json

    mount API::V1::Base => '/'

    get '/' do
      {}
    end

    route :any, '*path' do
      error!('Not found', 404)
    end
  end
end
