# frozen_string_literal: true

class ArtistResource < ApplicationResource
  immutable

  ##
  # Attributes
  #
  attributes :name,
             :aliases,
             :country,
             :date_of_birth,
             :date_of_death,
             :biography

  ##
  # Relationships
  #
  has_many :groups
  has_many :releases

  ##
  # Filters
  #
  ##
  # Methods
  #
  def name
    @model.names.find_by(primary: true).name
  end

  def aliases
    @model.names.where(primary: false).pluck :name
  end

  def country
    @model.country&.country
  end
end
