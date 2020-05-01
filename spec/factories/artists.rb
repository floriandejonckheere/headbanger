# frozen_string_literal: true

FactoryBot.define do
  factory :artist, class: "Artist" do
    name { FFaker::Name.name }
    alt_names { [] }
    description { "A #{DateTime.current.year - born_at.year} year old #{gender} artist from #{ISO3166::Country[country].name}." }
    born_at { FFaker::Time.between(20.years.ago, 50.years.ago) }
    died_at { [FFaker::Time.between(born_at, DateTime.current), nil, nil].sample }
    gender { %w(male female).sample }
    country { ISO3166::Country.codes.sample }
  end
end
