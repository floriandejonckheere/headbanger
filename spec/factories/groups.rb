# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: "Graph::Group" do
    name { FFaker::Metal.group }
    alt_names { [] }
    description { "A band from #{country.name}." }
    formed_at { FFaker::Time.between(50.years.ago, DateTime.current) }
    state { Graph::Group::STATES.sample }
    country { ISO3166::Country.codes.sample }
  end
end
