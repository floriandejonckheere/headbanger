# frozen_string_literal: true

FactoryBot.define do
  factory :genre, class: "Genre" do
    initialize_with { Genre.find_or_initialize_by(name: name) }

    name { Genre.flat_taxonomy.sample }
  end
end
