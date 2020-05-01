# frozen_string_literal: true

ActiveRecord::Base.transaction do
  puts "-- Creating users"

  models = {
    genres: Group.all.to_a,
    artists: Artist.all.to_a,
    releases: Release.all.to_a,
  }

  rand(100..200).times do
    user = FactoryBot.create(:user)
    puts "    > #{user.email}"

    rateables = Array
      .new(rand(50..200)) { models[[:genres, :artists, :releases].sample].sample }
      .uniq(&:id)

    rateables.each { |r| user.ratings.build(rateable: r, rating: [:like, :dislike].sample) }

    user.save!
  end
end
