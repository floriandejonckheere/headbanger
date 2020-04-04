# frozen_string_literal: true

##
# Allows a node to rate
#
module Rating
  extend ActiveSupport::Concern

  included do
    ##
    # Attributes
    #
    ##
    # Associations
    #
    has_many :out,
             :rated,
             type: :rates,
             model_class: %i(Artist Group Release),
             unique: { on: :uuid }

    ##
    # Methods
    #
  end
end
