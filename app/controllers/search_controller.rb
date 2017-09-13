# frozen_string_literal: true

class SearchController < ApplicationController
  # POST /search
  def create
    # TODO: search in Genre and Release
    results = Name.search(resource_params[:query]).map(&:performer)

    @resources = SearchResource.resources_for results, context

    jsonapi_render :json => @resources
  end
end
