# frozen_string_literal: true

module Types
  class MusicType < BaseUnion
    description "A music object"
    possible_types ArtistType, GroupType, ReleaseType
  end
end
