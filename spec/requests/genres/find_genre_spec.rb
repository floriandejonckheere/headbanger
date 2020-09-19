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

  it "returns error when not authenticated" do
    find_genre(nil, "notfound")

    expect(response).to have_errors "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :genre)).to be_nil
  end

  it "returns nothing when not found" do
    find_genre(default_user, "notfound")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :genre)).to be_nil
  end

  it "returns genres" do
    group = create(:group, name: "my_group")
    genre = create(:genre, name: "my_genre", groups: [group])

    find_genre(default_user, genre.id)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :genre, :id)).to eq genre.id
    expect(response_body.dig(:data, :genre, :name)).to eq "my_genre"
    expect(response_body.dig(:data, :genre, :description)).to eq genre.description
    expect(response_body.dig(:data, :genre, :groups, 0, :name)).to eq "my_group"
  end

  def find_genre(user, id)
    post graphql_path, params: { query: query.gsub("$id", id) }, headers: user&.create_new_auth_token
  end
end
