# frozen_string_literal: true

##
# Allows a node to follow and be followed
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
             :type => :following,
             :model_class => %i[Artist Group User]

    ##
    # Methods
    #
  end
end
