# frozen_string_literal: true

class ReleasesController < ApplicationController
  # GET /releases
  def index
    @resources = Release.all

    jsonapi_render json: @resources
  end

  # GET /releases/:id
  def show
    @resource = Release.find params[:id]

    jsonapi_render json: @resource
  end
end
