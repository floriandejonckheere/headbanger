# frozen_string_literal: true

module Rateable
  extend ActiveSupport::Concern

  included do
    has_many :in,
             :raters,
             type: :rates,
             model_class: "Graph::User",
             unique: { on: :uuid }
  end
end
