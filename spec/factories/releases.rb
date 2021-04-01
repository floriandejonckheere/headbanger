# frozen_string_literal: true

FactoryBot.define do
  factory :release, class: "Release" do
    name { FFaker::Metal.release }
    description { "A release from #{released_at.year}." }
    released_at { FFaker::Time.between(50.years.ago, DateTime.current) }
    synced_at { FFaker::Time.datetime }
  end
end
