# frozen_string_literal: true

##
# Generic name node
#
class Name
  include Neo4j::ActiveNode

  ##
  # Attributes
  #
  property :name
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
          :model_class => %i[artist group]

  ##
  # Methods
  #
end
