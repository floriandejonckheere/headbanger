# frozen_string_literal: true

RSpec.describe "Sign up" do
  let(:query) do
    <<-GRAPHQL
      mutation updateUser ($id: ID!, $name: String, $email: String, $password: String, $country: String) {
        updateUser (input: { id: $id, name: $name, email: $email, password: $password, country: $country }) {
          errors { message path }

          user {
              id
              name
              email
              country
          }
        }
      }
    GRAPHQL
  end

  let!(:user) { create(:user) }

  it "returns an error when not authorized" do
    update_user(id: create(:user).id, name: "John")

    expect(response).to have_error_codes "AUTHORIZATION_ERROR"
    expect(response_body.dig(:data, :updateUser, :user)).to be_nil
  end

  it "returns an error when object is not found" do
    update_user(id: "notfound", name: "John")

    expect(response).to have_error_codes "USER_ERROR"
    expect(response_body.dig(:data, :updateUser, :user)).to be_nil
  end

  it "updates a user" do
    update_user(id: user.id, name: "John")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :updateUser, :user, :name)).to eq "John"
  end

  def update_user(variables)
    post graphql_path,
         params: {
           query: query,
           variables: variables,
         },
         headers: user.create_new_auth_token
  end
end
