# frozen_string_literal: true

module Graph
  ##
  # A musical genre
  #
  class Genre < ApplicationRecord
    property :name,
             type: String,
             constraint: :unique

    validates :name,
              presence: true,
              uniqueness: true
  end
end
