# frozen_string_literal: true

class ReleaseResource < ApplicationResource
  immutable

  ##
  # Attributes
  #
  attributes :title,
             :year

  ##
  # Relationships
  #
  has_many :groups
  has_many :artists

  ##
  # Filters
  #
  ##
  # Methods
  #
end
