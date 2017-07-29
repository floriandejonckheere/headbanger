# frozen_string_literal: true

##
# A music genre
#
class Genre
  include Neo4j::ActiveNode

  searchkick :searchable => %i[name]

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

  has_many :out,
           :subgenres,
           :type => :related_to,
           :model_class => :Genre,
           :dependent => :delete_orphans, # No callbacks are run
           :unique => { :on => :name }

  has_many :in,
           :supergenres,
           :type => :related_to,
           :model_class => :Genre,
           :unique => { :on => :name }

  ##
  # Methods
  #
end
