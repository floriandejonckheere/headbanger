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
    release = create(:release, name: "my_release", groups: [group], artists: [artist])

    post graphql_path, params: { query: query_string }

    expect(response_body.dig("data", "releases", 0, "id")).to eq release.id
    expect(response_body.dig("data", "releases", 0, "name")).to eq "my_release"
    expect(response_body.dig("data", "releases", 0, "groups", 0, "name")).to eq "my_group"
    expect(response_body.dig("data", "releases", 0, "artists", 0, "name")).to eq "my_artist"
  end
end
