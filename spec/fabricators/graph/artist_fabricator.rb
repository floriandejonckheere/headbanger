Fabricator(:artist, :from => Graph::Artist) do
  gid { SecureRandom.uuid }
  date_of_birth { Faker::Date }

  artist_name(rand: 2)
end
