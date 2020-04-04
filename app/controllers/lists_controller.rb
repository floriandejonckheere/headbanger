# frozen_string_literal: true

class ListsController < ApplicationController
  # GET /lists
  def index
    @resources = List.all

    jsonapi_render json: @resources
  end

  # GET /lists/:id
  def show
    @resource = List.find params[:id]

    jsonapi_render json: @resource
  end
end
