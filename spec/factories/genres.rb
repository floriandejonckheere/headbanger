# frozen_string_literal: true

FactoryBot.define do
  factory :genre, class: "Graph::Genre" do
    name { Genre.name_for("#{FFaker::Lorem.word} Metal") }
  end
end
