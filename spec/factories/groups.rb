# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: "Graph::Group" do
    name { FFaker::Lorem.words(2).join(" ").capitalize }
    alt_names { [FFaker::Lorem.words(2).join(" ").capitalize] }
    description { FFaker::Lorem.words(20).join(" ").capitalize }
    formed_at { rand(50).year.ago }
    state { Graph::Group::STATES.sample }

    association :country, factory: :country
  end
end
