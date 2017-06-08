# frozen_string_literal: true

##
# A user's identity
#
class Identity
  include Neo4j::ActiveNode
  ##
  # Attributes
  #
  property :provider
  property :uid

  ##
  # Associations
  #
  has_one :in,
          :user,
          :type => :identifies_with

  ##
  # Methods
  #
end
