# frozen_string_literal: true

FactoryBot.define do
  factory :theme, class: "Graph::Theme" do
    name { FFaker::Lorem.words(3).join(" ").capitalize }
  end
end
