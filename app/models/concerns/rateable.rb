# frozen_string_literal: true

module Rateable
  extend ActiveSupport::Concern

  included do
    has_many :in,
             :likes,
             type: :likes,
             model_class: "Graph::User",
             unique: { on: :uuid }

    has_many :in,
             :dislikes,
             type: :dislikes,
             model_class: "Graph::User",
             unique: { on: :uuid }
  end
end
