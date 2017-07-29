# frozen_string_literal: true

##
# Generic name node
#
class Name < ApplicationRecord
  searchkick :searchable => %i[name]

  ##
  # Attributes
  #
  property :name
           # :index => :exact

  property :primary,
           :type => Boolean,
           :default => false

  validates :name,
            :presence => true

  ##
  # Associations
  #
  has_one :in,
          :performer,
          :type => :known_as,
          :model_class => %i[Artist Group]

  validates :performer,
            :presence => true

  ##
  # Methods
  #
end
