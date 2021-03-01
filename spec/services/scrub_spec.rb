# frozen_string_literal: true

RSpec.describe Scrub do
  subject(:scrub) { described_class.new }

  let(:sync_service) { instance_double("sync_service") }

  before { allow(sync_service).to receive(:call).and_return true }

  it "syncs objects" do
    artist = create(:artist, :expired)

    dinja_mock!("sync", artist) { sync_service }

    allow(sync_service).to receive(:call).and_return true

    scrub.call

    expect(sync_service).to have_received(:call)
  end

  it "syncs maximum N objects" do
    create_list(:artist, (Headbanger.config.sync_limit + 1), :expired)

    expect(scrub.scrubables.count).to eq Headbanger.config.sync_limit
  end

  it "sync only objects older than N" do
    create(:artist, :expired)
    create(:artist)

    expect(scrub.scrubables.count).to eq 1
  end
end
