# frozen_string_literal: true

RSpec.describe Recommend do
  subject(:recommend) { described_class.new(user) }

  let(:user) { create(:user) }

  before do
    create_list(:artist, 10)
    create_list(:release, 10)
    create_list(:group, 10)
  end

  it "truncates existing recommendations" do
    user.recommendations.concat(Array.new(11) { build(:recommendation) })

    recommend.call

    user.reload
    expect(user.recommendations.count).to eq Headbanger.config.recommendation_limit
  end

  it "generates recommendations" do
    recommend.call

    user.reload
    expect(user.recommendations).not_to be_empty
  end
end
