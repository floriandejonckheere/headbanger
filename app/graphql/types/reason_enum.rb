# frozen_string_literal: true

module Types
  class ReasonEnum < BaseEnum
    value :artist, "Similar based on artist"
    value :group, "Similar based on group"
    value :genre, "Similar based on genre"
  end
end
