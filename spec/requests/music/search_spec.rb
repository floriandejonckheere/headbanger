# frozen_string_literal: true

RSpec.describe "Search music" do
  let(:query) do
    <<-GRAPHQL
      query {
        results: search (query: "$query") {
          pageInfo { startCursor endCursor hasPreviousPage hasNextPage }

          edges {
            cursor

            node {
              __typename
              ... on Artist {
                id
                name
              }
              ... on Group {
                id
                name
              }
              ... on Release {
                id
                name
              }
            }
          }
        }
      }
    GRAPHQL
  end

  it "returns empty when nothing found" do
    post graphql_path, params: { query: query.gsub("$query", "notfound") }

    expect(response_body.dig("data", "results", "edges")).to be_empty
  end

  it "returns empty when query is shorter than three characters" do
    create(:group, name: "my_group")

    post graphql_path, params: { query: query.sub("$query", "my") }

    expect(response_body.dig("data", "results", "edges")).to be_empty
  end

  it "returns music" do
    group = create(:group, name: "my_group")

    post graphql_path, params: { query: query.gsub("$query", "my_group") }

    expect(response_body.dig("data", "results", "edges", 0, "node", "id")).to eq group.id
    expect(response_body.dig("data", "results", "edges", 0, "node", "name")).to eq "my_group"
  end
end
