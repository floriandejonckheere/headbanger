# frozen_string_literal: true

module Refreshable
  extend ActiveSupport::Concern

  def fresh?
    updated_at? && (updated_at + Headbanger.config.data_expires_in).future?
  end

  def stale?
    !fresh?
  end
end
