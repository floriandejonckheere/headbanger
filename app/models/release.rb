# frozen_string_literal: true

require 'converters/metal_archives/nil_date_converter'

##
# A release
#
class Release
  include Neo4j::ActiveNode

  include Sourceable
  include Rateable

  searchkick :searchable => %i[title]

  ##
  # Attributes
  #
  property :title
           # :index => :exact

  property :year,
           :type => Integer

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
