FactoryGirl.define do
  factory :artist, :class => Graph::Artist do |a|
    gid SecureRandom.uuid
    date_of_birth Faker::Date.between(20.years.ago, 60.years.ago)

    # name_count is declared as a transient attribute and available in
    # attributes on the factory, as well as the callback via the evaluator
    transient do
      name_count 2
    end

    # the after(:create) yields two values; the artist instance itself and the
    # evaluator, which stores all values from the factory, including transient
    # attributes; `create_list`'s second argument is the number of records
    # to create and we make sure the artist is associated properly to the name
    after(:create) do |artist, evaluator|
      create_list :artist_name, evaluator.name_count, :artist => artist
    end
  end
end
