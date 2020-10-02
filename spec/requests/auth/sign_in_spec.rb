# frozen_string_literal: true

RSpec.describe "Sign in" do
  let(:query) do
    <<-GRAPHQL
      mutation signin ($email: String!, $password: String!) {
        userLogin (email: $email, password: $password) {
          authenticatable {
              id
              name
              email
              country
          }

          credentials {
            accessToken
            client
            expiry
            tokenType
            uid
          }
        }
      }
    GRAPHQL
  end

  let!(:user) { create(:user, email: "john.doe@example.com", password: "abcd1234") }

  it "returns an error when the credentials are not valid" do
    sign_in(email: "john.doe@example.com", password: "abcd12345")

    expect(response).to have_error_codes "USER_ERROR"
    expect(response_body.dig(:data, :userLogin)).to be_nil
  end

  it "returns a token" do
    sign_in(email: "john.doe@example.com", password: "abcd1234")

    expect(response).not_to have_errors

    credentials = response_body.dig(:data, :userLogin, :credentials)
    expect(credentials).to include expiry: a_kind_of(Integer), tokenType: "Bearer", uid: "john.doe@example.com"

    user.reload
    expect(user).to be_valid_token credentials[:accessToken], credentials[:client]
  end

  def sign_in(variables)
    post graphql_path,
         params: {
           query: query,
           variables: variables,
         }
  end
end
