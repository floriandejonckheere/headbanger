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
           # :constraint => :unique

  validates :name,
            :presence => true

  ##
  # Associations
  #
  has_many :in,
           :groups,
           :type => :sings_about,
           :unique => { :on => :metal_archives_key }

  ##
  # Methods
  #
end
