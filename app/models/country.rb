# frozen_string_literal: true

##
# A country
#
class Country
  include Neo4j::ActiveNode

  ##
  # Attributes
  #
  property :country,
           :type => String
  # :unique => true

  validates :country,
            :presence => true

  ##
  # Associations
  #
  has_many :in,
           :groups,
           :type => :based_in,
           :unique => true

  has_many :in,
           :artists,
           :type => :based_in,
           :unique => true

  ##
  # Methods
  #
end
