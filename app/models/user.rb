# frozen_string_literal: true

class User < ApplicationRecord
  validates :name,
            presence: true

  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :country,
            inclusion: { in: ISO3166::Country.codes },
            allow_nil: true

  # has_many :out,
  #          :likes,
  #          type: :likes,
  #          model_class: %w(Graph::Artist Graph::Group Graph::Release),
  #          unique: { on: :id }
  #
  # has_many :out,
  #          :dislikes,
  #          type: :dislikes,
  #          model_class: %w(Graph::Artist Graph::Group Graph::Release),
  #          unique: { on: :id }
end
