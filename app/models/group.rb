# frozen_string_literal: true

##
# A group of performers
#
class Group
  include Neo4j::ActiveNode
  include DataNode

  ##
  # Properties
  #
  property :year_formed,
           :type => Date
  property :description

  enum :status => %i[active split_up on_hold changed_name disputed unknown]

  ##
  # Associations
  #
  has_many :out,
           :names,
           :type => :known_as,
           :dependent => :delete, # No callbacks are run
           :unique => { :on => :name }

  has_one :out,
          :country,
          :type => :based_in

  has_many :in,
           :artists,
           :type => :member_of,
           :unique => true

  has_many :out,
           :lyrical_themes,
           :type => :sings_about,
           :dependent => :delete_orphans, # No callbacks are run
           :unique => true

  has_many :out,
           :genres,
           :type => :plays_genre,
           :unique => true

  has_many :out,
           :releases,
           :type => :has_released,
           :unique => true

  ##
  # Methods
  #
  def primary_name
    names.find_by :primary => true
  end
end
