# frozen_string_literal: true

RSpec.describe "Sign up" do
  let(:query) do
    <<-GRAPHQL
      mutation signup ($name: String!, $email: String!, $password: String!, $country: String!) {
        userSignUp (name: $name, email: $email, password: $password, passwordConfirmation: $password, country: $country, confirmSuccessUrl: "/") {
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

  it "returns an error when missing required fields" do
    sign_up(name: "John", email: "john.doe@example.com", password: "abcd1234", country: "")

    expect(response).to have_error_codes "USER_ERROR"
    expect(response_body.dig(:data, :userSignUp)).to be_nil
  end

  it "creates a user" do
    sign_up(name: "John", email: "john.doe@example.com", password: "abcd1234", country: "BE")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :userSignUp, :authenticatable)).to include name: "John",
                                                                               email: "john.doe@example.com",
                                                                               country: "BE"
  end

  it "returns a token" do
    sign_up(name: "John", email: "john.doe@example.com", password: "abcd1234", country: "BE")

    expect(response).not_to have_errors

    credentials = response_body.dig(:data, :userSignUp, :credentials)
    expect(credentials).to include expiry: a_kind_of(Integer), tokenType: "Bearer", uid: "john.doe@example.com"

    user = User.find_by(uid: "john.doe@example.com")
    expect(user).to be_valid_token credentials[:accessToken], credentials[:client]
  end

  def sign_up(variables)
    post graphql_path,
         params: {
           query: query,
           variables: variables,
         }
  end
end
