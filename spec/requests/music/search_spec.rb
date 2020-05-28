# frozen_string_literal: true

RSpec.describe "Search music" do
  let(:query) do
    <<-GRAPHQL
      query {
        search (query: "$query") {
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

    expect(response_body.dig("data", "search", "edges")).to be_empty
  end

  it "returns empty when query is shorter than three characters" do
    create(:group, name: "my_group")

    post graphql_path, params: { query: query.sub("$query", "my") }

    expect(response_body.dig("data", "search", "edges")).to be_empty
  end

  it "returns music" do
    group = create(:group, name: "my_group")

    post graphql_path, params: { query: query.gsub("$query", "my_group") }

    expect(response_body.dig("data", "search", "edges", 0, "node", "id")).to eq group.id
    expect(response_body.dig("data", "search", "edges", 0, "node", "name")).to eq "my_group"
  end

  it "returns maximum 5 results" do
    Array.new(6).map { |i| create(:group, name: "my_group_#{i}") }

    post graphql_path, params: { query: query.gsub("$query", "my_group") }

    expect(response_body.dig("data", "search", "edges").count).to eq 5
  end
end
