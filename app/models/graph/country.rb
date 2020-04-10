# frozen_string_literal: true

module Graph
  ##
  # A country
  #
  class Country < ApplicationRecord
    property :code,
             type: String,
             constraint: :unique

    validates :code,
              presence: true,
              uniqueness: true,
              inclusion: { in: ISO3166::Country.codes }
  end
end
