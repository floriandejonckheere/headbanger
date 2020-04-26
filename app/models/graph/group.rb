# frozen_string_literal: true

module Graph
  ##
  # A group of performers
  #
  class Group < ApplicationRecord
    include Identifiable
    include Refreshable
    include Rateable

    STATES = %w(active split_up on_hold changed_name disputed unknown).freeze

    property :name,
             type: String

    property :alt_names

    property :description,
             type: String

    property :formed_at,
             type: Date

    property :state,
             type: String,
             default: :active

    validates :name,
              presence: true

    validates :alt_names,
              presence: true,
              allow_blank: true

    validates :description,
              presence: true

    validates :formed_at,
              presence: true

    validates :state,
              presence: true,
              inclusion: { in: STATES }

    has_one :out,
            :country,
            type: :based_in,
            model_class: "Graph::Country",
            unique: { on: :id }

    has_many :in,
             :artists,
             type: :member_of,
             model_class: "Graph::Artist",
             unique: { on: :id }

    has_many :out,
             :releases,
             type: :releases,
             model_class: "Graph::Release",
             unique: { on: :id }

    has_many :out,
             :themes,
             type: :narrates_of,
             dependent: :destroy_orphans,
             model_class: "Graph::Theme",
             unique: { on: :id }

    has_many :out,
             :genres,
             type: :associated_with,
             model_class: "Graph::Genre",
             unique: { on: :id }
  end
end
