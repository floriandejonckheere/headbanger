FactoryGirl.define do
  factory :artist_name, :class => Graph::ArtistName do |a|
    name Faker::Name.name
    artist
  end
end
