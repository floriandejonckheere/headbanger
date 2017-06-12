# frozen_string_literal: true

class AppController < ApplicationController
  before_action :authenticate_user!, :except => %i[home discover]

  ##
  # Home
  #
  # GET /
  def home; end

  ##
  # Discover (recommendations)
  #
  # GET /discover
  def discover; end

  ##
  # Listening queue
  #
  # GET /queue
  def queue
    @queue = current_user.queued_items
  end
end
