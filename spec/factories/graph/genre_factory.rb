FactoryGirl.define do
  factory :genre, :class => Graph::Genre do |g|
    name Faker::Lorem.word
  end

  factory :subgenre, :parent => :genre do |sg|

  end
end
