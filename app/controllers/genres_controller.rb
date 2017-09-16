# frozen_string_literal: true

class GenresController < ApplicationController
  # GET /genres
  def index
    @resources = Genre.all

    jsonapi_render :json => @resources
  end

  # GET /genres/:id
  def show
    @resource = Genre.find params[:id]

    jsonapi_render :json => @resource
  end
end
