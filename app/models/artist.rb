# frozen_string_literal: true

##
# A single performer (but not a solo artist)
#
class Artist
  include Neo4j::ActiveNode
  include DataNode

  ##
  # Attributes
  #
  property :gender,
           :type => String
  property :date_of_birth,
           :type => Date
  property :date_of_death,
           :type => Date
  property :biography,
           :type => String

  ##
  # Associations
  #
  has_one :out,
          :country,
          :type => :based_in

  has_many :out,
           :names,
           :type => :known_as,
           :dependent => :delete, # No callbacks are run
           :unique => { :on => :name }

  has_many :out,
           :releases,
           :type => :appears_in,
           :unique => { :on => :musicbrainz_key }

  ##
  # Methods
  #
end
