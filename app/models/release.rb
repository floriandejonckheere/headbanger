# frozen_string_literal: true

##
# A release
#
class Release
  include Neo4j::ActiveNode
  include DataNode

  ##
  # Attributes
  #
  property :title
           # :index => :exact

  property :release_date,
           :type => Date

  ##
  # Associations
  #
  has_many :in,
           :groups,
           :type => :has_released,
           :unique => { :on => :metal_archives_key }

  has_many :in,
           :artists,
           :type => :appears_in,
           :unique => { :on => :metal_archives_key }

  ##
  # Methods
  #
end
