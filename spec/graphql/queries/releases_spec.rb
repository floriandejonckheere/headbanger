# frozen_string_literal: true

RSpec.describe "Query releases" do
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

    result = Schema.execute(query_string)

    expect(result.dig("data", "releases", 0, "id")).to eq release.id
    expect(result.dig("data", "releases", 0, "name")).to eq "my_release"
    expect(result.dig("data", "releases", 0, "groups", 0, "name")).to eq "my_group"
    expect(result.dig("data", "releases", 0, "artists", 0, "name")).to eq "my_artist"
  end
end
