# frozen_string_literal: true

RSpec.describe Scrub do
  subject(:scrub) { described_class.new }

  it "syncs objects" do
    artist = create(:artist, :expired)

    # rubocop:disable RSpec/AnyInstance, RSpec/StubbedMock
    expect_any_instance_of(artist.class)
      .to receive(:sync!)
      .and_return true
    # rubocop:enable RSpec/AnyInstance, RSpec/StubbedMock

    scrub.call
  end

  it "syncs maximum N objects" do
    create_list(:artist, (Headbanger.config.sync_limit + 1), :expired, synced_at: (Headbanger.config.data_expires_in + 1.day).ago)

    expect(scrub.scrubables.count).to eq Headbanger.config.sync_limit
  end

  it "sync only objects older than N" do
    create(:artist, :expired)
    create(:artist)

    expect(scrub.scrubables.count).to eq 1
  end
end
