FactoryGirl.define do
  factory :country, :class => Graph::Country do |c|
    country_code Faker::Address.country_code
  end
end
