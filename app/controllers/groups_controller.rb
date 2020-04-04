# frozen_string_literal: true

class GroupsController < ApplicationController
  # GET /groups
  def index
    @resources = Group.all

    jsonapi_render json: @resources
  end

  # GET /groups/:id
  def show
    @resource = Group.find params[:id]

    jsonapi_render json: @resource
  end
end
