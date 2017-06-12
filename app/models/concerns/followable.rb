# frozen_string_literal: true

##
# Allows a node to follow and be followed
#
module Followable
  extend ActiveSupport::Concern

  included do
    ##
    # Attributes
    #
    ##
    # Associations
    #
    has_many :in,
             :followers,
             :type => :following,
             :model_class => %i[Artist Group User],
             :unique => { :on => :uuid }

    ##
    # Methods
    #
  end
end
