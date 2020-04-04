# frozen_string_literal: true

class GroupResource < ApplicationResource
  immutable

  ##
  # Attributes
  #
  attributes :name,
             :aliases,
             :country,
             :year_formed,
             :status,
             :genres

  ##
  # Relationships
  #
  has_many :releases
  has_many :artists

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
    @model.country&.display_name
  end

  def genres
    @model.genres.pluck(:name)
  end
end
