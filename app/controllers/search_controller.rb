# frozen_string_literal: true

require "extensions/jsonapi/utils/response/formatters"

class SearchController < ApplicationController
  # GET /search/:id
  def show
    @resources = Name.search(params[:id]).map(&:performer) +
                 Genre.search(params[:id]) +
                 Release.search(params[:id])

    jsonapi_render json: @resources
  end
end
