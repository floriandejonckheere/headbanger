# frozen_string_literal: true

module Graph
  ##
  # A release
  #
  class Release < ApplicationRecord
    include Identifiable

    property :name,
             type: String

    property :released_at,
             type: DateTime

    validates :name,
              presence: true

    validates :released_at,
              presence: true

    has_many :in,
             :raters,
             type: :rates,
             model_class: :User,
             unique: { on: :uuid }

    has_many :in,
             :artists,
             type: :appears_on,
             model_class: :Artist,
             unique: { on: :id }

    has_one :in,
            :group,
            type: :released_by,
            model_class: :Group,
            unique: { on: :id }
  end
end
