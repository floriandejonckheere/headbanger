# frozen_string_literal: true

class GroupsController < ApplicationController
  include FollowableController
  include QueueableController
  include RateableController

  def show
    @group = Group.find params[:id]
  end
end
