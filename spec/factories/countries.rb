# frozen_string_literal: true

FactoryBot.define do
  factory :country, class: "Graph::Country" do
    to_create do |instance|
      instance.attributes = Country.find_or_create_by(code: instance.code).attributes
      instance.reload
    end

    code { ISO3166::Country.codes.sample }
  end
end
