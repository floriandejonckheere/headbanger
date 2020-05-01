# frozen_string_literal: true

ActiveRecord::Base.transaction do
  puts "-- Creating groups"

  rand(25..50).times do
    group = FactoryBot.create(:group)

    artists = [Artist.order("RANDOM()").limit(rand(2..4)), FactoryBot.build_list(:artist, rand(1..5))].flatten
    group.artists = artists

    group.themes = FactoryBot.create_list(:theme, rand(0..5)).uniq
    group.genres = FactoryBot.create_list(:genre, rand(1..2)).uniq

    group.save!
  end
end
