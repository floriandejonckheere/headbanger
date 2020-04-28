# frozen_string_literal: true

FactoryBot.define do
  factory :release, class: "Release" do
    name { FFaker::Metal.release }
    released_at { FFaker::Time.between(50.years.ago, DateTime.current) }
  end
end
