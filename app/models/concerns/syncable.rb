# frozen_string_literal: true

module Syncable
  extend ActiveSupport::Concern

  included do
    validates :synced_at,
              presence: true
  end

  def fresh?
    synced_at&.> Headbanger.config.data_expires_in.ago
  end

  def stale?
    !fresh?
  end
end
