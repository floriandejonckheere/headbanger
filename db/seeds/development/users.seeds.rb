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

    genres = [:genres, :artists, :releases]

    rateables = Array
      .new(rand(50..200)) { models[genres.sample].sample }
      .uniq(&:id)

    ratings = [:like, :dislike]

    rateables.each { |r| user.ratings.build(rateable: r, rating: ratings.sample) }

    user.save!
  end
end
