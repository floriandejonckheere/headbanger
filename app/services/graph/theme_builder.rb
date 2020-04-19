# frozen_string_literal: true

module Graph
  class ThemeBuilder < ApplicationBuilder
    def initialize(description:)
      super(name: theme_for(description))

      model.description = description
    end

    private

    def theme_for(description)
      description
        .underscore
        .gsub(/ +/, "_")
        .tr("/", "_")
    end
  end
end
