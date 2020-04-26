# frozen_string_literal: true

module Graph
  ##
  # A lyrical theme
  #
  class Theme < ApplicationRecord
    property :name,
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

    def description
      Theme.description_for(name)
    end

    class << self
      def name_for(description)
        description
          .parameterize(separator: "_")
      end

      def description_for(name)
        name&.titleize
      end
    end
  end
end
