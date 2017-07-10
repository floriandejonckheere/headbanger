# frozen_string_literal: true

class ArtistsController < ApplicationController
  include FollowableController
  include QueueableController
  include RateableController

  def show
    @artist = Artist.find params[:id]
  end
end
