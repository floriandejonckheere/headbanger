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

  def sync!(**options)
    Headbanger
      .container
      .resolve("#{self.class.name.downcase.pluralize}.sync", self, **options)
      .call
  end

  def synced?
    synced_at.present? && synced_at > Headbanger.config.data_expires_in.ago
  end

  def expired?
    !synced?
  end
end
