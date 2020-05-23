# frozen_string_literal: true

RSpec.describe "Get releases" do
  it "returns releases alphabetically" do
    query_string = <<-GRAPHQL
    query {
      releases {
        id
        name
        releasedAt
        groups { id name }
        artists { id name }
      }
    }
    GRAPHQL

    group = create(:group, name: "my_group")
    artist = create(:artist, name: "my_artist")
    release_b = create(:release, name: "my_release_b", groups: [group], artists: [artist])
    release_a = create(:release, name: "my_release_a", groups: [group], artists: [artist])
    release_c = create(:release, name: "my_release_c", groups: [group], artists: [artist])

    post graphql_path, params: { query: query_string }

    expect(response_body.dig("data", "releases", 0, "id")).to eq release_a.id
    expect(response_body.dig("data", "releases", 0, "name")).to eq "my_release_a"
    expect(response_body.dig("data", "releases", 0, "groups", 0, "name")).to eq "my_group"
    expect(response_body.dig("data", "releases", 0, "artists", 0, "name")).to eq "my_artist"

    expect(response_body.dig("data", "releases", 1, "id")).to eq release_b.id
    expect(response_body.dig("data", "releases", 2, "id")).to eq release_c.id
  end
end
