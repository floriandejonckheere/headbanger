# frozen_string_literal: true

module Graph
  ##
  # A release
  #
  class Release < ApplicationRecord
    include Identifiable

    property :name,
             type: String

    property :released_at,
             type: DateTime

    validates :name,
              presence: true

    validates :released_at,
              presence: true
  end
end
