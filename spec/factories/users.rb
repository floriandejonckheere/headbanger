FactoryGirl.define do
  factory :user do
    name  'John'
    email 'john@example.com'
  end

  factory :admin, :class => User do
    name  'Admin'
    email 'admin@example.com'
  end

end
