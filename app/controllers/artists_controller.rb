# frozen_string_literal: true

class ArtistsController < ApplicationController
  # GET /artists
  def index
    @resources = Artist.all

    jsonapi_render :json => @resources
  end

  # GET /artists/:id
  def show
    @resource = Artist.find params[:id]

    jsonapi_render :json => @resource
  end
end
