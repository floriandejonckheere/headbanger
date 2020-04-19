# frozen_string_literal: true

module Graph
  ##
  # A lyrical theme
  #
  class Theme < ApplicationRecord
    property :name,
             type: String

    property :description,
             type: String

    validates :name,
              presence: true,
              uniqueness: true

    validates :description,
              presence: true

    has_many :in,
             :groups,
             type: :narrates_of,
             model_class: "Graph::Group",
             unique: { on: :id }
  end
end
