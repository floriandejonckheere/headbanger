# frozen_string_literal: true

RSpec.describe "Search music" do
  let(:query) do
    <<-GRAPHQL
      query {
        results: search (query: "$query") {
          pageInfo { count startCursor endCursor hasPreviousPage hasNextPage }

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

  it "returns error when not authenticated" do
    search(nil, "notfound")

    expect(response).to have_error_codes "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :results)).to be_nil
  end

  it "returns empty when nothing found" do
    search(default_user, "notfound")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :results, :edges)).to be_empty
  end

  it "returns empty when query is shorter than three characters" do
    create(:group, name: "my_group")

    search(default_user, "my")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :results, :edges)).to be_empty
  end

  it "returns music" do
    group = create(:group, name: "my_group")

    search(default_user, "my_group")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :results, :edges, 0, :node, :id)).to eq group.id
    expect(response_body.dig(:data, :results, :edges, 0, :node, :name)).to eq "my_group"
  end

  def search(user, query_string)
    post graphql_path, params: { query: query.gsub("$query", query_string) }, headers: user&.create_new_auth_token
  end
end
