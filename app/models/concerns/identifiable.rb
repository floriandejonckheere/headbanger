# frozen_string_literal: true

##
# Allows a node to be updated from a data source
#
module Identifiable
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
