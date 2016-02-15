FactoryGirl.define do
  factory :artist, :class => Graph::Artist do |a|
    gid SecureRandom.uuid
    date_of_birth Faker::Date.between(20.years.ago, 60.years.ago)
  end
end
