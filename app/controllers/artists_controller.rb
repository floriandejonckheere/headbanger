# frozen_string_literal: true

class ArtistsController < ApplicationController
  include FollowableController

  def show
    @artist = Artist.find params[:id]
  end
end
