# frozen_string_literal: true

class UsersController < ApplicationController
  # GET /users
  def index
    @resources = User.all

    jsonapi_render :json => @resources
  end

  # GET /users/:id
  def show
    @resource = User.find params[:id]

    jsonapi_render :json => @resource
  end
end
