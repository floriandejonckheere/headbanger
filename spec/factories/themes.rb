# frozen_string_literal: true

FactoryBot.define do
  factory :theme, class: "Theme" do
    initialize_with { Theme.find_or_initialize_by(name: name) }

    name { FFaker::Metal.theme }
  end
end
