# frozen_string_literal: true

module Syncable
  extend ActiveSupport::Concern

  class_methods do
    def synced
      where(synced_at: Headbanger.config.data_expires_in.ago..)
    end

    def expired
      where(synced_at: nil)
        .or(where(synced_at: ..Headbanger.config.data_expires_in.ago))
    end
  end

  def synced?
    synced_at&.> Headbanger.config.data_expires_in.ago
  end

  def expired?
    !synced?
  end
end
