# frozen_string_literal: true

FactoryBot.define do
  factory :theme, class: "Graph::Theme" do
    to_create do |instance|
      instance.attributes = Graph::Theme.find_or_create_by(name: instance.name).attributes
      instance.reload
    end

    name { FFaker::Metal.theme }
  end
end
