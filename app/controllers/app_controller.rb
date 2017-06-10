# frozen_string_literal: true

class AppController < ApplicationController
  before_action :authenticate_user!, :except => %i[home discover]

  ##
  # Home
  #
  def home; end

  ##
  # Discover (recommendations)
  #
  def discover; end

  ##
  # Listening queue
  #
  def queue; end
end
