# frozen_string_literal: true

class ReleasesController < ApplicationController
  def show
    @release = Release.find_by! :musicbrainz_key => params[:id]
  end
end
