# frozen_string_literal: true

RSpec.describe "Delete user" do
  let(:query) do
    <<-GRAPHQL
      mutation deleteUser ($id: ID!) {
        deleteUser (input: { id: $id }) {
          errors { message path }
        }
      }
    GRAPHQL
  end

  let(:user) { create(:user) }

  it "returns an error when not authorized" do
    delete_user(id: create(:user).id)

    expect(response).to have_error_codes "AUTHORIZATION_ERROR"

    expect { user.reload }.not_to raise_error
  end

  it "returns an error when object is not found" do
    delete_user(id: "notfound")

    expect(response).to have_error_codes "USER_ERROR"

    expect { user.reload }.not_to raise_error
  end

  it "deletes a user" do
    delete_user(id: user.id)

    expect(response).not_to have_errors

    expect { user.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  def delete_user(variables)
    post graphql_path,
         params: {
           query: query,
           variables: variables,
         },
         headers: user.create_new_auth_token
  end
end
