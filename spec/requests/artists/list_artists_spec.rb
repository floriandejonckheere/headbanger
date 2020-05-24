# frozen_string_literal: true

RSpec.describe "List artists" do
  let(:query) do
    <<-GRAPHQL
      query {
        artists: listArtists {
          id
          name
          groups { id name }
        }
      }
    GRAPHQL
  end

  it "returns empty when nothing found" do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Queries::Artists::List)
      .to receive(:resolve)
      .and_return []
    # rubocop:enable RSpec/AnyInstance

    post graphql_path, params: { query: query }

    expect(response_body.dig("data", "artists")).to be_empty
  end

  it "returns artists alphabetically" do
    group = create(:group, name: "my_group")
    # Use 0_ as a prefix, because the database already contains seeded artists
    artist_b = create(:artist, name: "0_my_artist_b", groups: [group])
    artist_a = create(:artist, name: "0_my_artist_a", groups: [group])
    artist_c = create(:artist, name: "0_my_artist_c", groups: [group])

    post graphql_path, params: { query: query }

    expect(response_body.dig("data", "artists", 0, "id")).to eq artist_a.id
    expect(response_body.dig("data", "artists", 0, "name")).to eq "0_my_artist_a"
    expect(response_body.dig("data", "artists", 0, "groups", 0, "name")).to eq "my_group"

    expect(response_body.dig("data", "artists", 1, "id")).to eq artist_b.id
    expect(response_body.dig("data", "artists", 2, "id")).to eq artist_c.id
  end
end
