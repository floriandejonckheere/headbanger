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
  end
end
