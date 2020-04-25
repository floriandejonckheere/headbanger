# frozen_string_literal: true

neo4j_transaction do
  Rails.logger.info "-- Creating releases"

  rand(75..100).times do
    release = FactoryBot.create(:release)

    artists = [Graph::Artist.all.to_a.sample(rand(1..3)), FactoryBot.build_list(:artist, rand(1..3))].flatten
    release.artists = artists

    release.save!
  end
end
