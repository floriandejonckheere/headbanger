# frozen_string_literal: true

FactoryBot.define do
  factory :country, class: "Graph::Country" do
    initialize_with { Graph::Country.find_or_initialize_by(code: code) }

    code { ISO3166::Country.codes.sample }
  end
end
