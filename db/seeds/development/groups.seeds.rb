# frozen_string_literal: true

neo4j_transaction do
  Rails.logger.info "-- Creating groups"

  rand(25..50).times do
    group = FactoryBot.create(:group)

    artists = [Graph::Artist.all.to_a.sample(rand(2..4)), FactoryBot.build_list(:artist, rand(1..5))].flatten
    group.artists = artists

    releases = [
      Graph::Release.all.to_a.sample(rand(1..5)),
      FactoryBot.build_list(:release, rand(0..5), group: group),
    ].sample

    group.releases = releases

    group.themes = FactoryBot.create_list(:theme, rand(0..5))
    group.genres = FactoryBot.create_list(:genre, rand(1..2))

    group.save!
  end
end
