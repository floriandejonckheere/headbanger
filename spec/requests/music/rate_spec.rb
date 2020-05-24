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

  let(:user) { create(:user) }
  let(:group) { create(:group) }

  before { user }

  it "returns errors when rateable not found" do
    rate("Group", "notfound", :like)

    expect(response_body.dig("data", "rate", "rateable")).to be_nil
    expect(response_body.dig("data", "rate", "errors")).not_to be_empty
  end

  it "returns errors when rating is invalid" do
    rate("Group", group.id, "invalid")

    expect(response_body.dig("data", "rate", "rateable")).to be_nil
    expect(response_body.dig("data", "rate", "errors")).not_to be_empty
  end

  context "when a rating exists" do
    it "keeps the rating when it is the same" do
      create(:rating, rateable: group, user: user, rating: :like)

      rate("Group", group.id, :like)

      expect(response_body.dig("data", "rate", "rateable", "rating")).to eq "like"
    end

    it "changes rating when it is different" do
      create(:rating, rateable: group, user: user, rating: :like)

      rate("Group", group.id, :dislike)

      expect(response_body.dig("data", "rate", "rateable", "rating")).to eq "dislike"
    end

    it "deletes rating when it is nil" do
      create(:rating, rateable: group, user: user, rating: :like)

      rate("Group", group.id, nil)

      expect(response_body.dig("data", "rate", "rateable", "rating")).to be_nil
    end
  end

  it "creates a rating" do
    rate("Group", group.id, :like)

    expect(response_body.dig("data", "rate", "rateable", "rating")).to eq "like"
  end

  def rate(type, id, rating = nil)
    post graphql_path,
         params: {
           query: query
             .gsub("$type", type)
             .gsub("$id", id)
             .gsub("$rating", (rating.nil? ? "" : "\"#{rating}\"")),
         }
  end
end
