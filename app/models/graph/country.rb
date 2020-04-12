# frozen_string_literal: true

module Graph
  ##
  # A country
  #
  class Country < ApplicationRecord
    property :code,
             type: String

    validates :code,
              presence: true,
              uniqueness: true,
              inclusion: { in: ISO3166::Country.codes }

    has_many :in,
             :users,
             type: :based_in,
             model_class: "Graph::User",
             unique: { on: :id }

    has_many :in,
             :artists,
             type: :based_in,
             model_class: "Graph::Artist",
             unique: { on: :id }

    has_many :in,
             :groups,
             type: :based_in,
             model_class: "Graph::Group",
             unique: { on: :id }
  end
end
