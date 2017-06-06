# frozen_string_literal: true

##
# A lyrical theme
#
class LyricalTheme
  include Neo4j::ActiveNode

  ##
  # Attributes
  #
  property :name
  # :unique => true

  validates :name,
            :presence => true

  ##
  # Associations
  #
  has_many :in,
           :groups,
           :type => :sings_about,
           :unique => true

  ##
  # Methods
  #
end
