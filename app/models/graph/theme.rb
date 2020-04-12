# frozen_string_literal: true

module Graph
  ##
  # A lyrical theme
  #
  class Theme < ApplicationRecord
    property :name,
             type: String,
             constraint: :unique

    validates :name,
              presence: true,
              uniqueness: true

    has_many :in,
             :groups,
             type: :narrates_of,
             model_class: :Group,
             unique: { on: :id }
  end
end
