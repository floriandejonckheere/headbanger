# frozen_string_literal: true

FactoryGirl.define do
  factory :name do
    name { Faker::Name.name }
  end
end
