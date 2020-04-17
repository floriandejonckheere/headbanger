# frozen_string_literal: true

module Graph
  ##
  # A single artist
  #
  class Artist < ApplicationRecord
    include Identifiable

    GENDERS = %w(male female other unknown).freeze

    property :name,
             type: String

    property :alt_names,
             type: String

    property :description,
             type: String

    property :born_at,
             type: Date

    property :died_at,
             type: Date

    property :gender,
             type: String,
             default: :unknown

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

    serialize :alt_names

    has_one :out,
            :country,
            type: :based_in,
            model_class: "Graph::Country",
            unique: { on: :id }

    has_many :in,
             :raters,
             type: :rates,
             model_class: "Graph::User",
             unique: { on: :uuid }

    has_many :out,
             :groups,
             type: :member_of,
             model_class: "Graph::Group",
             unique: { on: :uuid }

    has_many :out,
             :releases,
             type: :appears_in,
             model_class: "Graph::Release",
             unique: { on: :uuid }
  end
end
