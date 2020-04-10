# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: "Graph::User" do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
  end
end
