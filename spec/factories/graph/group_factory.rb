FactoryGirl.define do
  factory :group, :class => Graph::Group do
  end

  factory :group_active, :parent => :group do
    year_formed Faker::Date.between(10.years.ago, 5.years.ago)
    status :active
  end

  factory :group_split_up, :parent => :group_active do
    status :split_up
  end

  factory :group_on_hold, :parent => :group_active do
    status :on_hold
  end

  factory :group_changed_name, :parent => :group_active do
    status :changed_name
  end

  factory :group_disputed, :parent => :group_active do
    status :disputed
  end

  factory :group_unknown, :parent => :group_active do
    status :unknown
  end
end
