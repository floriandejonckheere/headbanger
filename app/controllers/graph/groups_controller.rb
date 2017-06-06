# frozen_string_literal: true

module Graph
  class GroupsController < ApplicationController
    def show
      @group = Graph::Group.find_by! :musicbrainz_key => params[:id]
    end
  end
end
