# frozen_string_literal: true

RSpec.describe "List genres" do
  let(:query) do
    <<-GRAPHQL
      query {
        genres: listGenres {
          id
          name
          description
          groups { id name }
        }
      }
    GRAPHQL
  end

  it "returns genres alphabetically" do
    group = create(:group, name: "my_group")
    # Use 0_ as a prefix, because the database already contains seeded genres
    genre_b = create(:genre, name: "0_my_genre_b", groups: [group])
    genre_a = create(:genre, name: "0_my_genre_a", groups: [group])
    genre_c = create(:genre, name: "0_my_genre_c", groups: [group])

    post graphql_path, params: { query: query }

    expect(response_body.dig("data", "genres", 0, "id")).to eq genre_a.id
    expect(response_body.dig("data", "genres", 0, "name")).to eq "0_my_genre_a"
    expect(response_body.dig("data", "genres", 0, "description")).to eq genre_a.description
    expect(response_body.dig("data", "genres", 0, "groups", 0, "name")).to eq "my_group"

    expect(response_body.dig("data", "genres", 1, "id")).to eq genre_b.id
    expect(response_body.dig("data", "genres", 2, "id")).to eq genre_c.id
  end
end
