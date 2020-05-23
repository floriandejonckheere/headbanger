# frozen_string_literal: true

FactoryBot.define do
  factory :recommendation, class: "Recommendation" do
    recommended_type { %w(Artist Group Release).sample }
    recommended_id { create(recommended_type.underscore.to_sym).id }
    reason { %w(artist group genre).sample }

    association :user, factory: :user
  end
end
