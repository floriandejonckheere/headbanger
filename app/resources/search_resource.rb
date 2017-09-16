# frozen_string_literal: true

class SearchResource < ApplicationResource
  abstract

  ##
  # Attributes
  #
  attributes :query, :display_name

  key_type :string

  ##
  # Relationships
  #
  ##
  # Filters
  #
  ##
  # Methods
  #
  def fetchable_fields
    super - %i[query]
  end

  def display_name
    @model._model.display_name
  end

  class << self
    def resource_type_for(model)
      model.class.name.downcase
    end
  end
end
