# frozen_string_literal: true

RSpec.describe "Find genre" do
  let(:query) do
    <<-GRAPHQL
      query {
        genre: findGenre (id: "$id") {
          id
          name
          description
          groups { id name }
        }
      }
    GRAPHQL
  end

  it "returns nothing when not found" do
    post graphql_path, params: { query: query.gsub("$id", "notfound") }

    expect(response_body.dig("data", "genre")).to be_nil
  end

  it "returns genres" do
    group = create(:group, name: "my_group")
    genre = create(:genre, name: "my_genre", groups: [group])

    post graphql_path, params: { query: query.gsub("$id", genre.id) }

    expect(response_body.dig("data", "genre", "id")).to eq genre.id
    expect(response_body.dig("data", "genre", "name")).to eq "my_genre"
    expect(response_body.dig("data", "genre", "description")).to eq genre.description
    expect(response_body.dig("data", "genre", "groups", 0, "name")).to eq "my_group"
  end
end
