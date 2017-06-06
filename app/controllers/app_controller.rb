# frozen_string_literal: true

class AppController < ApplicationController
  layout 'session', :only => %i[terms_of_service privacy_policy]

  # Routes
  def discover
    @releases = Graph::Release.all
  end

  def queue; end

  def terms_of_service; end

  def privacy_policy; end
end
