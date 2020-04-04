# frozen_string_literal: true

class ListResource < ApplicationResource
  ##
  # Attributes
  #
  attributes :name, :description

  ##
  # Relationships
  #
  has_one :user

  has_many :items, polymorphic: true

  ##
  # Filters
  #
  ##
  # Methods
  #
end
