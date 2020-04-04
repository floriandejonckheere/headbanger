# frozen_string_literal: true

##
# A list of DataNodes
#
class List < ApplicationRecord
  ##
  # Attributes
  #
  property :name,
           type: String

  validates :name,
            presence: true

  property :description,
           type: String

  ##
  # Associations
  #
  has_one :in,
          :user,
          type: :has_listed

  validates :user,
            presence: true

  has_many :out,
           :items,
           type: :includes,
           model_class: %i(Artist Group Release),
           unique: { on: :uuid }

  ##
  # Methods
  #
end
