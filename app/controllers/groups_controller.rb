# frozen_string_literal: true

class GroupsController < ApplicationController
  include FollowableController

  def show
    @group = Group.find params[:id]
  end
end
