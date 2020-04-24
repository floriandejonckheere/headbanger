# frozen_string_literal: true

FactoryBot.define do
  factory :theme, class: "Graph::Theme" do
    name { Theme.name_for(FFaker::Lorem.words(3).join(" ")) }
  end
end
