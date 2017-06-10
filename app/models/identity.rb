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
           # :index => :exact

  property :uid

  ##
  # Associations
  #
  has_one :in,
          :user,
          :type => :identifies_with

  validates :user,
            :presence => true

  ##
  # Methods
  #
end
