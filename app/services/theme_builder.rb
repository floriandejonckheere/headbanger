# frozen_string_literal: true

class ThemeBuilder < ApplicationBuilder
  def initialize(description:)
    super(name: Theme.name_for(description))
  end
end
