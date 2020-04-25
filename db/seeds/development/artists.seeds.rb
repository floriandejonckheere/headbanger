# frozen_string_literal: true

neo4j_transaction do
  Rails.logger.info "-- Creating artists"

  rand(25..50).times do
    artist = FactoryBot.create(:artist)

    groups = [Graph::Group.all.to_a.sample(rand(2..4)), FactoryBot.build_list(:group, rand(0..5))].flatten
    artist.groups = groups

    releases = [
      Graph::Release.all.to_a.sample(rand(2..4)),
      FactoryBot.build_list(:release, rand(5..10), group: groups.sample),
    ].flatten

    artist.releases = releases

    artist.save!
  end
end
