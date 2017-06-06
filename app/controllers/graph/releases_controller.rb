# frozen_string_literal: true

module Graph
  class ReleasesController < ApplicationController
    def show
      @release = Graph::Release.find_by! :musicbrainz_key => params[:id]
    end
  end
end
