# frozen_string_literal: true

module Graph
  ##
  # A release
  #
  class Release < ApplicationRecord
    include Identifiable
    include Refreshable

    property :name,
             type: String

    property :released_at,
             type: Date

    validates :name,
              presence: true

    validates :released_at,
              presence: true

    has_many :in,
             :raters,
             type: :rates,
             model_class: "Graph::User",
             unique: { on: :uuid }

    has_many :in,
             :artists,
             type: :appears_on,
             model_class: "Graph::Artist",
             unique: { on: :id }

    has_many :in,
             :group,
             type: :released_by,
             model_class: "Graph::Group",
             unique: { on: :id }
  end
end
