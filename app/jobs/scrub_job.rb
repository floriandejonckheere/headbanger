# frozen_string_literal: true

class ScrubJob < ApplicationJob
  def perform
    Scrub.new.call
  end
end
