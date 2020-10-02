# frozen_string_literal: true

RSpec.describe "Find artist" do
  let(:query) do
    <<-GRAPHQL
      query {
        artist: findArtist (id: "$id") {
          id
          name
          groups { id name }
        }
      }
    GRAPHQL
  end

  it "returns error when not authenticated" do
    find_artist(nil, "notfound")

    expect(response).to have_error_codes "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :artist)).to be_nil
  end

  it "returns nothing when not found" do
    find_artist(default_user, "notfound")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :artist)).to be_nil
  end

  it "returns artists" do
    group = create(:group, name: "my_group")
    artist = create(:artist, name: "my_artist", groups: [group])

    find_artist(default_user, artist.id)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :artist, :id)).to eq artist.id
    expect(response_body.dig(:data, :artist, :name)).to eq "my_artist"
    expect(response_body.dig(:data, :artist, :groups, 0, :name)).to eq "my_group"
  end

  def find_artist(user, id)
    post graphql_path, params: { query: query.gsub("$id", id) }, headers: user&.create_new_auth_token
  end
end
