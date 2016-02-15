Fabricator(:user) do
  name { Faker::Name.name }
  email { |attrs| "#{attrs[:name].parameterize}@example.com" }
end
