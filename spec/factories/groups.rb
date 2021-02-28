# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: "Group" do
    name { FFaker::Metal.group }
    alt_names { [] }
    description { "A band from #{ISO3166::Country[country].name}." }
    formed_at { FFaker::Time.between(50.years.ago, DateTime.current) }
    status { Group::STATUSES.sample }
    country { ISO3166::Country.codes.sample }
    synced_at { FFaker::Time.datetime }
  end
end
