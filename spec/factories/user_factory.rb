FactoryGirl.define do
  factory :user, :class => User do |u|
    password = Faker::Internet.password

    name { Faker::Name.name }
    email { Faker::Internet.email }
    password password
    password_confirmation password
    admin false
  end
end
