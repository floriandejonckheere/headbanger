# frozen_string_literal: true

module Graph
  ##
  # A single artist
  #
  class Artist < ApplicationRecord
    include Identifiable

    GENDERS = %w(male female other unknown).freeze

    STATES = %w(active split_up on_hold changed_name disputed unknown).freeze

    property :name,
             type: String

    property :alt_names,
             type: String

    property :description,
             type: String

    property :born_at,
             type: DateTime

    property :died_at,
             type: DateTime

    property :gender,
             type: String,
             default: :unknown

    property :state,
             type: String,
             default: :active

    validates :name,
              presence: true

    validates :alt_names,
              presence: true

    validates :description,
              presence: true

    validates :born_at,
              presence: true

    validates :gender,
              presence: true,
              inclusion: { in: GENDERS }

    validates :state,
              presence: true,
              inclusion: { in: STATES }

    serialize :alt_names
  end
end
