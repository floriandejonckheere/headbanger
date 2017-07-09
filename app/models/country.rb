# frozen_string_literal: true

##
# A country
#
class Country
  include Neo4j::ActiveNode

  ##
  # Attributes
  #
  property :country,
           :type => String
           # :constraint => :unique

  validates :country,
            :presence => true

  ##
  # Associations
  #
  has_many :in,
           :groups,
           :type => :based_in,
           :unique => { :on => :metal_archives_key }

  has_many :in,
           :artists,
           :type => :based_in,
           :unique => { :on => :metal_archives_key }

  ##
  # Methods
  #
  def display_name
    ISO3166::Country.find_country_by_alpha3(country).to_s
  end
end
