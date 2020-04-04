# frozen_string_literal: true

FactoryGirl.define do
  factory :artist do
    gender { Faker::Lorem.word }
    date_of_birth { Faker::Date.between 60.years.ago, 20.years.ago }
    date_of_death { Faker::Date.between 20.years.ago, Time.zone.today }
    biography { Faker::Lorem.words 100 }

    country { ISO3166::Country[Faker::Address.country_code] }

    names { build_list :name, 2 }

    trait :with_releases do
      releases { build_list :release, 3 }
    end

    # Set one primary name
    after(:create) do |artist|
      artist.names.first.primary = true
    end
  end
end
