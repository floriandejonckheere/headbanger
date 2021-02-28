# frozen_string_literal: true

module Syncable
  extend ActiveSupport::Concern

  included do
    validates :synced_at,
              presence: true
  end
end
