# frozen_string_literal: true

module Graph
  class ThemeBuilder < ApplicationBuilder
    def initialize(description:)
      super(name: Theme.name_for(description))
    end
  end
end
