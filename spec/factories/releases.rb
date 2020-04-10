# frozen_string_literal: true

FactoryBot.define do
  factory :country, class: "Graph::Country" do
    code { ISO3166::Country.code.sample }
  end
end
