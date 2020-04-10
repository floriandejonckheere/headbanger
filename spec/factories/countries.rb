# frozen_string_literal: true

FactoryBot.define do
  factory :release, class: "Graph::Release" do
    name { FFaker::Lorem.words(2).join(" ").capitalize }
    released_at { rand(50).year.ago }
  end
end
