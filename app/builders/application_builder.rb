# frozen_string_literal: true

class ApplicationBuilder
  attr_reader :model

  def initialize(**params)
    @model = model_class.find_or_initialize_by(**params)
  end

  def call
    # Return if data is not stale
    return model if model.respond_to?(:fresh?) && model.fresh?
    return model if !model.respond_to?(:fresh?) && model.persisted?

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

  def sanitize(string)
    ActionView::Base.full_sanitizer.sanitize string
  end

  def model_class
    self.class.name.remove("Builder").constantize
  end
end
