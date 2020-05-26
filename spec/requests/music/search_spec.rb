# frozen_string_literal: true

RSpec.describe "Search music" do
  let(:query) do
    <<-GRAPHQL
      query {
        results: search (query: "$query") {
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
    GRAPHQL
  end

  it "returns empty when nothing found" do
    post graphql_path, params: { query: query.gsub("$query", "notfound") }

    expect(response_body.dig("data", "results")).to be_empty
  end

  it "returns music" do
    group = create(:group, name: "my_group")

    post graphql_path, params: { query: query.gsub("$query", "my_") }

    expect(response_body.dig("data", "results", 0, "id")).to eq group.id
    expect(response_body.dig("data", "results", 0, "name")).to eq "my_group"
  end
end
