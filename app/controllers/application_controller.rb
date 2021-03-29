# frozen_string_literal: true

class ApplicationController < ActionController::API
  include GraphqlDevise::Concerns::SetUserByToken

  before_action :set_sentry_context

  def index
    head :no_content
  end

  private

  def set_sentry_context
    Sentry.with_scope do |scope|
      scope.set_tags(instance: ENV.fetch("VUE_APP_INSTANCE", "development"))
      scope.set_extras(params: params.to_unsafe_h, url: request.url)
    end
  end
end
