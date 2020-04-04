# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JSONAPI::Utils

  rescue_from JSONAPI::Exceptions::Error, with: :jsonapi_render_errors
  rescue_from ActiveRecord::RecordNotFound, with: :jsonapi_render_not_found

  ##
  # API url for link generation
  #
  def base_url
    @base_url ||= "#{request.protocol}#{request.host_with_port}/api"
  end
end
