FactoryGirl.define do
  factory :release, :class => Graph::Release do
    name { Faker::Lorem.words 3 }
    release_date { Faker::Date.between 20.years.ago, 1.years.from_now }
  end
end
