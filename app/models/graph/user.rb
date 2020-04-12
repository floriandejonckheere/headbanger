# frozen_string_literal: true

module Graph
  ##
  # A user
  #
  class User < ApplicationRecord
    property :email,
             type: String

    property :name,
             type: String

    validates :email,
              presence: true,
              format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :name,
              presence: true

    has_one :out,
            :country,
            type: :based_in,
            model_class: :Country,
            unique: { on: :id }

    has_many :out,
             :rated,
             type: :rates,
             model_class: %i(Artist Group Release),
             unique: { on: :id }
  end
end
