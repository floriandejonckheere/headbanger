class AppController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping

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
  def index
  end

  def trending
  end

  def discover
  end

  def explore
  end
end
