# frozen_string_literal: true

RSpec.describe "Get recommendations" do
  let(:query) do
    <<-GRAPHQL
      query {
        recommendations: getRecommendations {
          pageInfo { count startCursor endCursor hasPreviousPage hasNextPage }

          edges {
            cursor

            node {
              reason

              recommended {
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
      }
    GRAPHQL
  end

  let!(:user) { create(:user) }

  it "returns error when not authenticated" do
    get_recommendations(nil)

    expect(response).to have_errors "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :recommendations)).to be_nil
  end

  it "returns empty when nothing found" do
    get_recommendations(default_user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :recommendations, :edges)).to be_empty
  end

  it "returns recommendations" do
    group = create(:group, name: "my_group")
    user.recommendations.create(recommended: group, reason: :group)

    get_recommendations(user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :recommendations, :edges, 0, :node, :reason)).to eq "group"
    expect(response_body.dig(:data, :recommendations, :edges, 0, :node, :recommended, :__typename)).to eq "Group"
    expect(response_body.dig(:data, :recommendations, :edges, 0, :node, :recommended, :id)).to eq group.id
    expect(response_body.dig(:data, :recommendations, :edges, 0, :node, :recommended, :name)).to eq "my_group"
  end

  def get_recommendations(user)
    post graphql_path, params: { query: query }, headers: user&.create_new_auth_token
  end
end
