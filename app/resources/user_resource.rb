# frozen_string_literal: true

class UserResource < ApplicationResource
  immutable

  ##
  # Attributes
  #
  attribute :name

  ##
  # Relationships
  #
  has_many :lists
  has_many :followers, class_name: "User"
  has_many :following, polymorphic: true

  ##
  # Filters
  #
  ##
  # Methods
  #
end
