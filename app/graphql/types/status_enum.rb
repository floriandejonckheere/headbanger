# frozen_string_literal: true

module Types
  class StatusEnum < BaseEnum
    value :active, "Active"
    value :split_up, "Split up"
    value :on_hold, "On hold"
    value :changed_name, "Changed name"
    value :disputed, "Disputed"
  end
end
