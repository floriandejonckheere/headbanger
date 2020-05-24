# frozen_string_literal: true

RSpec.describe "Find artist" do
  let(:query) do
    <<-GRAPHQL
      query {
        artist: findArtist (id: "$id") {
          id
          name
          groups { id name }
        }
      }
    GRAPHQL
  end

  it "returns nothing when not found" do
    post graphql_path, params: { query: query.gsub("$id", "notfound") }

    expect(response_body.dig("data", "artist")).to be_nil
  end

  it "returns artists" do
    group = create(:group, name: "my_group")
    artist = create(:artist, name: "my_artist", groups: [group])

    post graphql_path, params: { query: query.gsub("$id", artist.id) }

    expect(response_body.dig("data", "artist", "id")).to eq artist.id
    expect(response_body.dig("data", "artist", "name")).to eq "my_artist"
    expect(response_body.dig("data", "artist", "groups", 0, "name")).to eq "my_group"
  end
end
