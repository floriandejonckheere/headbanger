# frozen_string_literal: true

FactoryBot.define do
  factory :genre, class: "Graph::Genre" do
    to_create do |instance|
      instance.attributes = Graph::Genre.find_or_create_by(name: instance.name).attributes
      instance.reload
    end

    code { Genre.flat_taxonomy.sample }
  end
end
