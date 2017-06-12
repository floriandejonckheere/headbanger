# frozen_string_literal: true

##
# Node containing data source information
#
module Sourceable
  extend ActiveSupport::Concern

  included do
    include Neo4j::Timestamps

    ##
    # Attributes
    #
    property :musicbrainz_key,
             :type => String
             # :constraint => :unique

    property :metal_archives_key,
             :type => String
             # :constraint => :unique

    ##
    # Associations
    #
    has_many :in,
             :lists,
             :type => :includes,
             :unique => { :on => :uuid }

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
