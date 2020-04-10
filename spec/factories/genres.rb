# frozen_string_literal: true

FactoryBot.define do
  factory :genre, class: "Graph::Genre" do
    name { [FFaker::Lorem.word, "Metal"].join(" ").capitalize }
  end
end
