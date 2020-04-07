# frozen_string_literal: true

class ApplicationController < ActionController::API
  def index
    render json: { status: :ok }
  end
end
