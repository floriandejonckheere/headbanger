class Graph::GroupsController < ApplicationController
  def show
    @group = Graph::Group.find_by! :musicbrainz_key => params[:id]
  end
end
