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

  has_many :out,
           :subgenres,
           :type => :related_to,
           :model_class => :genre,
           :dependent => :delete_orphans, # No callbacks are run
           :unique => { :on => :name }

  has_many :in,
           :supergenres,
           :type => :related_to,
           :model_class => :genre,
           :unique => { :on => :name }

  ##
  # Methods
  #
end
