# frozen_string_literal: true

RSpec.describe "List artists" do
  let(:query) do
    <<-GRAPHQL
      query {
        artists: listArtists {
          pageInfo { count startCursor endCursor hasPreviousPage hasNextPage }

          edges {
            cursor

            node {
              id
              name
              groups { id name }
            }
          }
        }
      }
    GRAPHQL
  end

  it "returns error when not authenticated" do
    list_artists(nil)

    expect(response).to have_error_codes "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :artists)).to be_nil
  end

  it "returns empty when nothing found" do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Queries::Artists::List)
      .to receive(:resolve)
      .and_return []
    # rubocop:enable RSpec/AnyInstance

    list_artists(default_user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :artists, :edges)).to be_empty
  end

  it "returns artists alphabetically" do
    group = create(:group, name: "my_group")
    # Use 0_ as a prefix, because the database already contains seeded artists
    artist_b = create(:artist, name: "0_my_artist_b", groups: [group])
    artist_a = create(:artist, name: "0_my_artist_a", groups: [group])
    artist_c = create(:artist, name: "0_my_artist_c", groups: [group])

    list_artists(default_user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :artists, :edges, 0, :node, :id)).to eq artist_a.id
    expect(response_body.dig(:data, :artists, :edges, 0, :node, :name)).to eq "0_my_artist_a"
    expect(response_body.dig(:data, :artists, :edges, 0, :node, :groups, 0, :name)).to eq "my_group"
    expect(response_body.dig(:data, :artists, :edges, 1, :node, :id)).to eq artist_b.id
    expect(response_body.dig(:data, :artists, :edges, 2, :node, :id)).to eq artist_c.id
  end

  def list_artists(user)
    post graphql_path, params: { query: query }, headers: user&.create_new_auth_token
  end
end
