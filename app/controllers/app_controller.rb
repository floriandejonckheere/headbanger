class AppController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping

  layout 'session', :only => [:terms_of_service, :privacy_policy]

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Routes
  def home
  end

  def discover
  end

  def explore
  end

  def terms_of_service; end
  def privacy_policy; end
end
