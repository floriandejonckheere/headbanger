# frozen_string_literal: true

##
# Allows a node to be rated
#
module Rateable
  extend ActiveSupport::Concern

  included do
    ##
    # Attributes
    #
    ##
    # Associations
    #
    has_many :in,
             :raters,
             :type => :rates,
             :model_class => :User,
             :unique => { :on => :uuid }

    ##
    # Methods
    #
  end
end
