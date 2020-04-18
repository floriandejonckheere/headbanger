# frozen_string_literal: true

module Graph
  class CountryBuilder
    attr_accessor :model

    def initialize(code:)
      @model = Graph::Country.find_or_initialize_by(code: code)
    end

    def call
      # Return if data is not stale
      return model if model.fresh?

      model.save!

      model
    end
  end
end
