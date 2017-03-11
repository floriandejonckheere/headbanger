class AppController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping

  layout 'session', :only => [:terms_of_service, :privacy_policy]

  # Routes
  def discover; end

  def terms_of_service; end
  def privacy_policy; end
end
