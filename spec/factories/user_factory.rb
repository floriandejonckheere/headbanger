FactoryGirl.define do
  factory :user, :class => User do |u|
    name Faker::Name.name
    email { |attrs| "#{attrs[:name].parameterize}@example.com" }
    admin false
  end

  factory :admin, :class => User do |u|
    name Faker::Name.name
    email { |attrs| "#{attrs[:name].parameterize}@example.com" }
    admin true
  end
end
