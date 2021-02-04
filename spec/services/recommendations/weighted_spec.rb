# frozen_string_literal: true

RSpec.describe Recommendations::Weighted do
  subject(:service) { described_class.new(user) }

  let(:user) { create(:user) }

  let!(:genre0) { create(:genre, name: "power") }
  let!(:genre1) { create(:genre, name: "death") }
  let!(:genre2) { create(:genre, name: "black") }

  let!(:artist0) { create(:artist, name: "artist0") }
  let!(:artist1) { create(:artist, name: "artist1") }
  let!(:artist2) { create(:artist, name: "artist2") }
  let!(:artist3) { create(:artist, name: "artist3") }
  let!(:artist4) { create(:artist, name: "artist4") }
  let!(:artist5) { create(:artist, name: "artist5") }
  let!(:artist6) { create(:artist, name: "artist6") }

  let!(:release0) { create(:release, name: "release0") }
  let!(:release1) { create(:release, name: "release1") }
  let!(:release2) { create(:release, name: "release2") }
  let!(:release3) { create(:release, name: "release3") }
  let!(:release4) { create(:release, name: "release4") }
  let!(:release5) { create(:release, name: "release5") }

  let!(:group0) { create(:group, name: "group0", genres: [genre0], artists: [artist0, artist1], releases: [release0, release1]) }
  let!(:group1) { create(:group, name: "group1", genres: [genre0], artists: [artist1, artist2], releases: [release2]) }
  let!(:group2) { create(:group, name: "group2", genres: [genre1], artists: [artist3, artist4], releases: []) }
  let!(:group3) { create(:group, name: "group3", genres: [genre1], artists: [artist4], releases: [release3]) }
  let!(:group4) { create(:group, name: "group4", genres: [genre2], artists: [artist5, artist6], releases: [release4, release5]) }

  let!(:user0) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  before do
    # subject likes a bit of power metal
    user.ratings.create(rateable: group0, rating: :like)
    user.ratings.create(rateable: release1, rating: :like)
    user.ratings.create(rateable: release2, rating: :like)
    user.ratings.create(rateable: artist1, rating: :like)

    # user0 likes power metal, and a bit of death
    user0.ratings.create(rateable: group0, rating: :like)
    user0.ratings.create(rateable: artist0, rating: :like)
    user0.ratings.create(rateable: artist1, rating: :like)
    user0.ratings.create(rateable: release1, rating: :like)
    user0.ratings.create(rateable: release2, rating: :like)

    user0.ratings.create(rateable: release3, rating: :like)

    # user1 likes black metal
    user1.ratings.create(rateable: group4, rating: :like)
    user1.ratings.create(rateable: artist5, rating: :like)
    user1.ratings.create(rateable: artist6, rating: :like)
    user1.ratings.create(rateable: release4, rating: :like)
    user1.ratings.create(rateable: release5, rating: :like)

    # user2 likes death metal, and a bit of power
    user2.ratings.create(rateable: group2, rating: :like)
    user2.ratings.create(rateable: group3, rating: :like)
    user2.ratings.create(rateable: artist4, rating: :like)

    user2.ratings.create(rateable: release0, rating: :like)
    user2.ratings.create(rateable: release1, rating: :like)
  end

  context "when user0 likes group1" do
    before { user0.ratings.create(rateable: group1, rating: :like) }

    it "creates recommendations" do
      expect(service.call(3).map { |r| r.recommended.name })
        .to match_array %w(group1 artist0 release3)
    end
  end

  context "when user0 dislikes group1" do
    before { user0.ratings.create(rateable: group1, rating: :dislike) }

    it "creates recommendations" do
      expect(service.call(3).map { |r| r.recommended.name })
        .to match_array %w(artist0 release3 release0)
    end
  end
end
