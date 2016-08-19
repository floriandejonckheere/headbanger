FactoryGirl.define do
  factory :artist, :class => Graph::Artist do
  end

  factory :artist_alive, :parent => :artist do
    date_of_birth Faker::Date.between(20.years.ago, 60.years.ago)
  end

  factory :artist_dead, :parent => :artist_alive do
    date_of_death Faker::Date.between(20.years.ago, Time.now)
  end
end
