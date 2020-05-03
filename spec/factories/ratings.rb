# frozen_string_literal: true

FactoryBot.define do
  factory :rating, class: "Rating" do
    rateable_type { %w(Artist Group Release).sample }
    rateable_id { create(rateable_type.underscore.to_sym).id }
    rating { %w(like dislike).sample }

    association :user, factory: :user
  end
end
