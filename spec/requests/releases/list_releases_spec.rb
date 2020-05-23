# frozen_string_literal: true

RSpec.describe "List releases" do
  let(:query) do
    <<-GRAPHQL
      query {
        releases: listReleases {
          id
          name
          releasedAt
          rating
          groups { id name }
          artists { id name }
        }
      }
    GRAPHQL
  end

  let(:user) { create(:user) }

  before { user }

  it "returns empty when nothing found" do
    post graphql_path, params: { query: query }

    expect(response_body.dig("data", "releases")).to be_empty
  end

  it "returns releases alphabetically" do
    group = create(:group, name: "my_group")
    artist = create(:artist, name: "my_artist")
    release_b = create(:release, name: "my_release_b", groups: [group], artists: [artist])
    release_a = create(:release, name: "my_release_a", groups: [group], artists: [artist])
    release_c = create(:release, name: "my_release_c", groups: [group], artists: [artist])

    post graphql_path, params: { query: query }

    expect(response_body.dig("data", "releases", 0, "id")).to eq release_a.id
    expect(response_body.dig("data", "releases", 0, "name")).to eq "my_release_a"
    expect(response_body.dig("data", "releases", 0, "groups", 0, "name")).to eq "my_group"
    expect(response_body.dig("data", "releases", 0, "artists", 0, "name")).to eq "my_artist"

    expect(response_body.dig("data", "releases", 1, "id")).to eq release_b.id
    expect(response_body.dig("data", "releases", 2, "id")).to eq release_c.id
  end

  it "returns ratings" do
    release_a = create(:release, name: "my_release_a")
    release_b = create(:release, name: "my_release_b")
    release_c = create(:release, name: "my_release_c")

    create(:rating, user: user, rateable: release_a, rating: :like)
    create(:rating, user: user, rateable: release_b, rating: :dislike)

    post graphql_path, params: { query: query }

    expect(response_body.dig("data", "releases", 0, "id")).to eq release_a.id
    expect(response_body.dig("data", "releases", 0, "rating")).to eq "like"
    expect(response_body.dig("data", "releases", 1, "id")).to eq release_b.id
    expect(response_body.dig("data", "releases", 1, "rating")).to eq "dislike"
    expect(response_body.dig("data", "releases", 2, "id")).to eq release_c.id
    expect(response_body.dig("data", "releases", 2, "rating")).to be_nil
  end
end
