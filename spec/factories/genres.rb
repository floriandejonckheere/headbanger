# frozen_string_literal: true

FactoryBot.define do
  factory :genre, class: "Graph::Genre" do
    initialize_with { Graph::Genre.find_or_initialize_by(name: name) }

    name { Graph::Genre.flat_taxonomy.sample }
  end
end
