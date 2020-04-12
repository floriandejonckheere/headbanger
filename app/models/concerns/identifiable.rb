# frozen_string_literal: true

##
# Allows a node to be updated from a data source
#
module Identifiable
  extend ActiveSupport::Concern

  included do
    property :musicbrainz_key,
             type: String

    property :metal_archives_key,
             type: String

    validates :musicbrainz_key,
              uniqueness: true,
              allow_blank: true

    validates :metal_archives_key,
              uniqueness: true,
              allow_blank: true
  end
end
