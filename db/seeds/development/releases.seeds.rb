# frozen_string_literal: true

ActiveRecord::Base.transaction do
  puts "-- Creating releases"

  250.times do
    release = FactoryBot.create(:release)

    artists = [Artist.order("RANDOM()").limit(rand(1..3)), FactoryBot.build_list(:artist, rand(1..3))].flatten
    release.artists = artists

    release.groups = Group.order("RANDOM()").limit(rand(0..1))

    release.save!
  end
end
