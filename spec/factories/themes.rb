# frozen_string_literal: true

FactoryBot.define do
  factory :theme, class: "Graph::Theme" do
    initialize_with { Graph::Theme.find_or_initialize_by(name: name) }

    name { FFaker::Metal.theme }
  end
end
