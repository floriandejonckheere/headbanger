# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: "User" do
    name { FFaker::Name.name }
    email { FFaker::Internet.email(name) }
    country { ISO3166::Country.codes.sample }

    password { FFaker::Internet.password }
    uid { email }

    role { "user" }

    factory :admin do
      role { "admin" }
    end
  end
end
