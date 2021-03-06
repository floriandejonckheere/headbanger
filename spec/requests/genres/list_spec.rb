# frozen_string_literal: true

RSpec.describe "List genres" do
  let(:query) do
    <<-GRAPHQL
      query {
        genres: listGenres {
          pageInfo { count startCursor endCursor hasPreviousPage hasNextPage }

          edges {
            cursor

            node {
              id
              name
              description
              groups { id name }
            }
          }
        }
      }
    GRAPHQL
  end

  it "returns error when not authenticated" do
    list_genres(nil)

    expect(response).to have_error_codes "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :genres)).to be_nil
  end

  it "returns empty when nothing found" do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Queries::Genres::List)
      .to receive(:resolve)
      .and_return []
    # rubocop:enable RSpec/AnyInstance

    list_genres(default_user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :genres, :edges)).to be_empty
  end

  it "returns genres alphabetically" do
    group = create(:group, name: "my_group")
    # Use 0_ as a prefix, because the database already contains seeded genres
    genre_b = create(:genre, name: "0_my_genre_b", groups: [group])
    genre_a = create(:genre, name: "0_my_genre_a", groups: [group])
    genre_c = create(:genre, name: "0_my_genre_c", groups: [group])

    list_genres(default_user)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :genres, :edges, 0, :node, :id)).to eq genre_a.id
    expect(response_body.dig(:data, :genres, :edges, 0, :node, :name)).to eq "0_my_genre_a"
    expect(response_body.dig(:data, :genres, :edges, 0, :node, :description)).to eq genre_a.description
    expect(response_body.dig(:data, :genres, :edges, 0, :node, :groups, 0, :name)).to eq "my_group"

    expect(response_body.dig(:data, :genres, :edges, 1, :node, :id)).to eq genre_b.id
    expect(response_body.dig(:data, :genres, :edges, 2, :node, :id)).to eq genre_c.id
  end

  def list_genres(user)
    post graphql_path, params: { query: query }, headers: user&.create_new_auth_token
  end
end
