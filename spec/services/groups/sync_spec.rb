# frozen_string_literal: true

RSpec.describe Groups::Sync do
  subject(:service) { described_class.new(group) }

  let(:group) { create(:group, :expired) }

  before do
    source = dinja_mock!("groups.source", any_args)

    allow(source)
      .to receive(:musicbrainz_key)
      .and_return "musicbrainz_key"

    allow(source)
      .to receive(:attributes)
      .and_return name: "name", alt_names: ["alt_names"], description: "description"
  end

  it "does nothing if model was recently synchronized" do
    group = build(:group, synced_at: 10.seconds.ago)
    service = described_class.new(group)

    Timecop.freeze do
      service.call

      expect(group).not_to be_within(1.second).of Time.zone.now
    end
  end

  it "raises when no key is present" do
    group = build(:group, metal_archives_key: nil)
    service = described_class.new(group)

    expect { service.call }.to raise_error ImportError
  end

  it "sets musicbrainz_key" do
    service.call

    group.reload
    expect(group.musicbrainz_key).to eq "musicbrainz_key"
  end

  it "sets attributes" do
    service.call

    group.reload
    expect(group.name).to eq "name"
    expect(group.alt_names).to eq ["alt_names"]
    expect(group.description).to eq "description"
  end

  it "sets synced_at" do
    Timecop.freeze do
      service.call

      group.reload
      expect(group.synced_at).to be_within(1.second).of Time.zone.now
    end
  end
end
