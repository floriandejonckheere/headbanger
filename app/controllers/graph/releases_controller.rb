class Graph::ReleasesController < ApplicationController
  def show
    @release = Graph::Release.find_by! :musicbrainz_key => params[:id]
  end
end
