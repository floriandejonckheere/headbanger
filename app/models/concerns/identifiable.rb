# frozen_string_literal: true

module Identifiable
  extend ActiveSupport::Concern

  included do
    validates :metal_archives_key,
              uniqueness: true,
              allow_nil: true

    validates :musicbrainz_key,
              uniqueness: true,
              allow_nil: true
  end
end
