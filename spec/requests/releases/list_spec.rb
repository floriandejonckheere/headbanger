# frozen_string_literal: true

RSpec.describe "List releases" do
  let(:query) do
    <<-GRAPHQL
      query {
        releases: listReleases {
          pageInfo { count startCursor endCursor hasPreviousPage hasNextPage }

          edges {
            cursor

            node {
              id
              name
              releasedAt
              rating
              groups { id name }
              artists { id name }
            }
          }
        }
      }
    GRAPHQL
  end

  let!(:user) { create(:user) }

  it "returns error when not authenticated" do
    list_releases(nil)

    expect(response).to have_error_codes "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :releases)).to be_nil
  end

  it "returns empty when nothing found" do
    list_releases(default_user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :releases, :edges)).to be_empty
  end

  it "returns releases alphabetically" do
    group = create(:group, name: "my_group")
    artist = create(:artist, name: "my_artist")
    release_b = create(:release, name: "my_release_b", groups: [group], artists: [artist])
    release_a = create(:release, name: "my_release_a", groups: [group], artists: [artist])
    release_c = create(:release, name: "my_release_c", groups: [group], artists: [artist])

    list_releases(default_user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :releases, :edges, 0, :node, :id)).to eq release_a.id
    expect(response_body.dig(:data, :releases, :edges, 0, :node, :name)).to eq "my_release_a"
    expect(response_body.dig(:data, :releases, :edges, 0, :node, :groups, 0, :name)).to eq "my_group"
    expect(response_body.dig(:data, :releases, :edges, 0, :node, :artists, 0, :name)).to eq "my_artist"

    expect(response_body.dig(:data, :releases, :edges, 1, :node, :id)).to eq release_b.id
    expect(response_body.dig(:data, :releases, :edges, 2, :node, :id)).to eq release_c.id
  end

  it "returns ratings" do
    release_a = create(:release, name: "my_release_a")
    release_b = create(:release, name: "my_release_b")
    release_c = create(:release, name: "my_release_c")

    create(:rating, user: user, rateable: release_a, rating: :like)
    create(:rating, user: user, rateable: release_b, rating: :dislike)

    list_releases(user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :releases, :edges, 0, :node, :id)).to eq release_a.id
    expect(response_body.dig(:data, :releases, :edges, 0, :node, :rating)).to eq "like"
    expect(response_body.dig(:data, :releases, :edges, 1, :node, :id)).to eq release_b.id
    expect(response_body.dig(:data, :releases, :edges, 1, :node, :rating)).to eq "dislike"
    expect(response_body.dig(:data, :releases, :edges, 2, :node, :id)).to eq release_c.id
    expect(response_body.dig(:data, :releases, :edges, 2, :node, :rating)).to be_nil
  end

  def list_releases(user)
    post graphql_path, params: { query: query }, headers: user&.create_new_auth_token
  end
end
