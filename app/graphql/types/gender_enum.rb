# frozen_string_literal: true

module Types
  class GenderEnum < BaseEnum
    value :male, "Male"
    value :female, "Female"
    value :other, "Other"
  end
end
