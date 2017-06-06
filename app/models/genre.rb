# frozen_string_literal: true

##
# A music genre
#
class Genre
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

  has_many :in,
           :subgenres,
           :type => :related_to,
           :model_class => :genre,
           :unique => { :on => :name }

  has_many :out,
           :supergenres,
           :type => :related_to,
           :model_class => :genre,
           :unique => { :on => :name }

  ##
  # Methods
  #
end
