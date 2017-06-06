# frozen_string_literal: true

class GroupsController < ApplicationController
  def show
    @group = Group.find_by! :musicbrainz_key => params[:id]
  end
end
