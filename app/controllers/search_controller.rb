# frozen_string_literal: true

class SearchController < ApplicationController
  # GET /search/:id
  def show
    results = Name.search(params[:id]).map(&:performer) +
              Genre.search(params[:id]) +
              Release.search(params[:id])

    @resources = SearchResource.resources_for results, context

    jsonapi_render :json => @resources
  end
end
