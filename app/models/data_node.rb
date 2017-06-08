# frozen_string_literal: true

##
# Node containing data source information
#
module DataNode
  extend ActiveSupport::Concern

  included do
    ##
    # Attributes
    #
    property :musicbrainz_key,
             :type => String
    # :unique => true
    property :metal_archives_key,
             :type => String
    # :unique => true

    property :updated_at,
             :type => DateTime

    ##
    # Associations
    #
    has_many :in,
             :lists,
             :type => :includes,
             :model_class => :list

    ##
    # Methods
    #
    ##
    # Whether the instance is up to date
    #
    def fresh?
      updated_at? && (updated_at + 6.months).future?
    end

    ##
    # Whether the instance is out of date
    #
    def stale?
      !fresh?
    end
  end
end
