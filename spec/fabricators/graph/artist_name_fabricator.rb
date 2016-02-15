Fabricator(:artist_name, :from => Graph::Artist) do
  name { Faker::Name.name }
end
