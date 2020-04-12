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

    has_one :out,
            :country,
            type: :based_in,
            model_class: :Country,
            unique: { on: :id }

    has_many :in,
             :artists,
             type: :member_of,
             model_class: :Artist,
             unique: { on: :id }

    has_many :out,
             :releases,
             type: :released_by,
             model_class: :Release,
             unique: { on: :id }

    has_many :out,
             :themes,
             type: :narrates_of,
             dependent: :destroy_orphans,
             model_class: :Theme,
             unique: { on: :id }

    has_many :out,
             :genres,
             type: :associated_with,
             model_class: :Genre,
             unique: { on: :id }

    has_many :in,
             :raters,
             type: :rates,
             model_class: :User,
             unique: { on: :uuid }
  end
end
