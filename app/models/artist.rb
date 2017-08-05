# frozen_string_literal: true

require 'converters/metal_archives/nil_date_converter'

##
# A single performer (but not a solo artist)
#
class Artist < ApplicationRecord
  include Identifiable
  include Followable
  include Rateable

  ##
  # Attributes
  #
  property :gender,
           :type => String

  property :date_of_birth,
           :type => MetalArchives::NilDate

  property :date_of_death,
           :type => MetalArchives::NilDate

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
           :groups,
           :type => :member_of,
           :unique => { :on => :metal_archives_key }

  has_many :out,
           :releases,
           :type => :appears_in,
           :unique => { :on => :metal_archives_key }

  ##
  # Methods
  #
  def display_name
    names.find_by(:primary => true).name
  end
end
