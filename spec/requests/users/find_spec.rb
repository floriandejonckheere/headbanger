# frozen_string_literal: true

RSpec.describe "Find user" do
  let(:query) do
    <<-GRAPHQL
      query {
        user: findUser (id: "$id") {
          id
          name
          email
          country
        }
      }
    GRAPHQL
  end

  it "returns error when not authenticated" do
    find_user(nil, "notfound")

    expect(response).to have_error_codes "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :user)).to be_nil
  end

  it "returns nothing when not found" do
    find_user(default_user, "notfound")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :user)).to be_nil
  end

  it "returns user" do
    user = create(:user, name: "my_user")

    find_user(default_user, user.id)

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :user, :id)).to eq user.id
    expect(response_body.dig(:data, :user, :name)).to eq "my_user"
  end

  def find_user(user, id)
    post graphql_path, params: { query: query.gsub("$id", id) }, headers: user&.create_new_auth_token
  end
end
