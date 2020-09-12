# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :set_raven_context

  def index
    head :no_content
  end

  private

  def set_raven_context
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
