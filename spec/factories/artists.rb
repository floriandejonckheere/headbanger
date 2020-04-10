# frozen_string_literal: true

FactoryBot.define do
  factory :artist, class: "Graph::Artist" do
    name { FFaker::Name.name }
    alt_names { [FFaker::Lorem.words(2).join(" ").capitalize] }
    description { FFaker::Lorem.words(20).join(" ").capitalize }
    born_at { rand(20..50).year.ago }
    died_at { [rand(20).year.ago, nil].sample }
    gender { Graph::Artist::GENDERS.sample }
  end
end
