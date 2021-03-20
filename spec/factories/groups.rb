# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: "Group" do
    name { FFaker::Metal.group }
    alt_names { [] }
    description { "A band from #{ISO3166::Country[country].name}." }
    formed_on { FFaker::Time.between(50.years.ago, DateTime.current) }
    status { Group::STATUSES.sample }
    country { ISO3166::Country.codes.sample }
    synced_at { 10.seconds.ago }

    metal_archives_key { FFaker::Guid.guid }
    musicbrainz_key { FFaker::Guid.guid }

    trait :expired do
      synced_at { (Headbanger.config.data_expires_in + 1.day).ago }
    end
  end
end
