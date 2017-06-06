# frozen_string_literal: true

FactoryGirl.define do
  factory :name, :class => Graph::Name do
    name { Faker::Name.name }
  end
end
