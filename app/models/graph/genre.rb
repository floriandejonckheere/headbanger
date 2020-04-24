# frozen_string_literal: true

module Graph
  ##
  # A musical genre
  #
  class Genre < ApplicationRecord
    property :name,
             type: String

    validates :name,
              presence: true,
              uniqueness: true

    has_many :in,
             :groups,
             type: :associated_with,
             model_class: "Graph::Group",
             unique: { on: :id }

    has_many :out,
             :subgenres,
             type: :related_to,
             model_class: "Graph::Genre",
             unique: { on: :id }

    has_many :in,
             :supergenres,
             type: :related_to,
             model_class: "Graph::Genre",
             unique: { on: :id }

    def description
      Genre.description_for(name)
    end

    class << self
      def taxonomy
        @taxonomy ||= YAML.load_file(Rails.root.join("data/genres.yml"))
      end

      def flat_taxonomy
        @flat_taxonomy ||= taxonomy.flatten.flatten.compact
      end

      def name_for(description)
        description
          .parameterize(separator: "_")
          .gsub(/_?metal/, "")
      end

      def description_for(name)
        "#{name.titleize} Metal"
      end
    end
  end
end
