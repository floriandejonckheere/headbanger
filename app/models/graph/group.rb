# frozen_string_literal: true

module Graph
  ##
  # A group of performers
  #
  class Group < ApplicationRecord
    include Identifiable

    STATES = %w(active split_up on_hold changed_name disputed unknown).freeze

    property :name,
             type: String

    property :alt_names,
             type: String

    property :description,
             type: String

    property :formed_at,
             type: DateTime

    property :state,
             type: String,
             default: :active

    validates :name,
              presence: true

    validates :alt_names,
              presence: true

    validates :description,
              presence: true

    validates :formed_at,
              presence: true

    validates :state,
              presence: true,
              inclusion: { in: STATES }

    serialize :alt_names
  end
end
