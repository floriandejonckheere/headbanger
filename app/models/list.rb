# frozen_string_literal: true

##
# A list of DataNodes
#
class List
  include Neo4j::ActiveNode

  ##
  # Attributes
  #
  property :name,
           :type => String
  property :description,
           :type => Date

  ##
  # Associations
  #
  has_one :in,
          :author,
          :type => :has_listed,
          :model_class => :user

  has_many :out,
           :items,
           :type => :includes,
           :model_class => %i[artist group release],
           :unique => { :on => :musicbrainz_key }

  ##
  # Methods
  #
end
