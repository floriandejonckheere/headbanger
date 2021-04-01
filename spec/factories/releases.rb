# frozen_string_literal: true

FactoryBot.define do
  factory :release, class: "Release" do
    name { FFaker::Metal.release }
    description { "A release from #{released_at.year}." }
    released_at { FFaker::Time.between(50.years.ago, DateTime.current) }
    synced_at { FFaker::Time.datetime }

    metal_archives_key { FFaker::Guid.guid }
    musicbrainz_key { FFaker::Guid.guid }

    trait :expired do
      synced_at { (Headbanger.config.data_expires_in + 1.day).ago }
    end
  end
end
