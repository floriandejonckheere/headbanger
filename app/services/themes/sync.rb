# frozen_string_literal: true

module Themes
  class Sync
    attr_reader :theme

    def initialize(theme)
      @theme = theme
    end

    def call
      raise ImportError, "no name available" unless theme.name?

      # Persist model
      theme.save!

      theme
    end
  end
end
