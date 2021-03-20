# frozen_string_literal: true

module Syncable
  extend ActiveSupport::Concern

  def synced?
    synced_at&.> Headbanger.config.data_expires_in.ago
  end

  def expired?
    !synced?
  end
end
