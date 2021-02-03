# frozen_string_literal: true

RSpec.describe Recommendations::Dummy do
  subject(:service) { described_class.new(user) }

  let(:user) { create(:user) }

  let!(:artist) { create(:artist) }
  let!(:group) { create(:group) }
  let!(:release) { create(:release) }

  it "creates recommendations" do
    expect(service.call(3).map(&:recommended)).to match_array [artist, group, release]
  end
end
