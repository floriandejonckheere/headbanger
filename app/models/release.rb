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
  property :release_date,
           :type => Date

  ##
  # Associations
  #
  has_many :in,
           :groups,
           :type => :has_released,
           :unique => { :on => :musicbrainz_key }

  has_many :in,
           :artists,
           :type => :appears_in,
           :unique => { :on => :musicbrainz_key }

  ##
  # Methods
  #
end
