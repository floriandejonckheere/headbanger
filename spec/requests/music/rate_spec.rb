# frozen_string_literal: true

RSpec.describe "Rate music" do
  let(:query) do
    <<-GRAPHQL
      mutation {
        rate (input: { type: "$type", id: "$id", rating: $rating }) {
          errors

          rateable {
            ...on Artist { id rating }
            ...on Group { id rating }
            ...on Release { id rating }
          }
        }
      }
    GRAPHQL
  end

  let!(:user) { create(:user) }
  let(:group) { create(:group) }

  it "returns error when not authenticated" do
    rate(nil, "Group", "notfound", :like)

    expect(response).to have_error_codes "AUTHENTICATION_ERROR"
    expect(response_body.dig(:data, :rate)).to be_nil
  end

  it "returns errors when rateable not found" do
    rate(default_user, "Group", "notfound", :like)

    expect(response_body.dig(:data, :rate, :rateable)).to be_nil
    expect(response_body.dig(:data, :rate, :errors)).not_to be_empty
  end

  it "returns errors when rating is invalid" do
    rate(default_user, "Group", group.id, "invalid")

    expect(response_body.dig(:data, :rate, :rateable)).to be_nil
    expect(response_body.dig(:data, :rate, :errors)).not_to be_empty
  end

  context "when a rating exists" do
    it "keeps the rating when it is the same" do
      create(:rating, rateable: group, user: user, rating: :like)

      rate(default_user, "Group", group.id, :like)

      expect(response_body.dig(:data, :rate, :rateable, :rating)).to eq "like"
    end

    it "changes rating when it is different" do
      create(:rating, rateable: group, user: user, rating: :like)

      rate(default_user, "Group", group.id, :dislike)

      expect(response_body.dig(:data, :rate, :rateable, :rating)).to eq "dislike"
    end

    it "deletes rating when it is nil" do
      create(:rating, rateable: group, user: user, rating: :like)

      rate(default_user, "Group", group.id, nil)

      expect(response_body.dig(:data, :rate, :rateable, :rating)).to be_nil
    end
  end

  it "creates a rating" do
    rate(default_user, "Group", group.id, :like)

    expect(response_body.dig(:data, :rate, :rateable, :rating)).to eq "like"
  end

  def rate(user, type, id, rating = nil)
    post graphql_path,
         params: {
           query: query
             .gsub("$type", type)
             .gsub("$id", id)
             .gsub("$rating", (rating.nil? ? "" : "\"#{rating}\"")),
         },
         headers: user&.create_new_auth_token
  end
end
