# frozen_string_literal: true

module Graph
  class ApplicationBuilder
    attr_reader :model

    def initialize(**params)
      @model = model_class.find_or_initialize_by(**params)
    end

    def call
      # Return if data is not stale
      if model.respond_to?(:fresh)
        return model if model.fresh?
      else
        return model if model.persisted?
      end

      # Assemble attributes
      attributes

      # Assemble associations
      associations

      # Persist
      model.save!
      model
    end

    protected

    def attributes; end

    def associations; end

    def model_class
      self.class.name.remove("Builder").constantize
    end
  end
end
