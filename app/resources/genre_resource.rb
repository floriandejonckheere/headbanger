# frozen_string_literal: true

class GenreResource < ApplicationResource
  immutable

  ##
  # Attributes
  #
  attribute :name

  ##
  # Relationships
  #
  has_many :subgenres, :class_name => 'Genre'
  has_many :supergenres, :class_name => 'Genre'

  ##
  # Filters
  #
  ##
  # Methods
  #
end
