# frozen_string_literal: true

RSpec.describe "Sign up" do
  let(:query) do
    <<-GRAPHQL
      mutation updateUser ($userId: ID!, $name: String, $email: String, $password: String, $country: String) {
        updateUser (input: { userId: $userId, name: $name, email: $email, password: $password, country: $country }) {
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

  it "returns an error when object is not found" do
    update_user(user_id: "notfound", name: "John")

    expect(response).to have_errors
    expect(response_body.dig(:data, :updateUser, :user)).to be_nil
  end

  it "updates a user" do
    update_user(user_id: user.id, name: "John")

    expect(response).not_to have_errors
    expect(response_body.dig(:data, :updateUser, :user, :name)).to eq "John"
  end

  def update_user(variables)
    post graphql_path,
         params: {
           query: query,
           variables: variables.transform_keys { |k| k.to_s.camelize(:lower).to_sym },
         },
         headers: user.create_new_auth_token
  end
end
