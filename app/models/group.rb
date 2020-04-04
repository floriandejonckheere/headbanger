# frozen_string_literal: true

require "converters/metal_archives/nil_date_converter"

##
# A group of performers
#
class Group < ApplicationRecord
  include Identifiable
  include Followable
  include Rateable

  ##
  # Properties
  #
  property :year_formed,
           type: MetalArchives::NilDate

  property :description

  enum status: { active: 0, split_up: 1, on_hold: 2, changed_name: 3, disputed: 4, unknown: 5 }

  ##
  # Associations
  #
  has_many :out,
           :names,
           type: :known_as,
           dependent: :delete, # No callbacks are run
           unique: { on: :name }

  has_one :out,
          :country,
          type: :based_in

  has_many :in,
           :artists,
           type: :member_of,
           unique: { on: :metal_archives_key }

  has_many :out,
           :lyrical_themes,
           type: :sings_about,
           dependent: :delete_orphans, # No callbacks are run
           unique: { on: :metal_archives_key }

  has_many :out,
           :genres,
           type: :plays_genre,
           unique: { on: :name }

  has_many :out,
           :releases,
           type: :has_released,
           unique: { on: :metal_archives_key }

  ##
  # Methods
  #
  def display_name
    names.find_by(primary: true).name
  end
end
