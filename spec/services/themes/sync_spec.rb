# frozen_string_literal: true

RSpec.describe Themes::Sync do
  subject(:service) { described_class.new(theme) }

  let(:theme) { build(:theme) }

  it "returns theme" do
    expect(service.call).to be_persisted
  end
end
