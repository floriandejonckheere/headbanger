# frozen_string_literal: true

##
# Allows a node to follow
#
module Following
  extend ActiveSupport::Concern

  included do
    ##
    # Attributes
    #
    ##
    # Associations
    #
    has_many :out,
             :following,
             :type => :follows,
             :model_class => %i[Artist Group User],
             :unique => { :on => :uuid }

    ##
    # Methods
    #
  end
end
