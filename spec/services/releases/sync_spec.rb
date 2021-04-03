# frozen_string_literal: true

RSpec.describe Releases::Sync do
  subject(:service) { described_class.new(release, full: false) }

  let(:release) { create(:release, synced_at: nil) }

  before do
    allow(Headbanger.container)
      .to receive(:resolve)
      .and_call_original

    allow(Headbanger.container)
      .to receive(:resolve)
        .with("releases.source", any_args) { Releases::SourceMock.new }

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("artists.sync", any_args) do |_key, artist, **_options|
      instance_double("artists.sync")
        .tap { |d| allow(d).to receive(:call).and_return artist }
    end

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("groups.sync", any_args) do |_key, group, **_options|
      instance_double("groups.sync")
        .tap { |d| allow(d).to receive(:call).and_return group }
    end
  end

  it "raises when no key is present" do
    release = build(:release, metal_archives_key: nil)
    service = described_class.new(release)

    expect { service.call }.to raise_error ImportError
  end

  it "does nothing if model was recently synchronized" do
    release = build(:release, updated_at: 10.seconds.ago, synced_at: 10.seconds.ago)
    service = described_class.new(release)

    Timecop.freeze do
      service.call

      expect(release.updated_at).not_to be_within(1.second).of Time.zone.now
    end
  end

  it "synchronizes model if force is true" do
    release = build(:release, updated_at: 10.seconds.ago, synced_at: 10.seconds.ago)
    service = described_class.new(release, force: true)

    Timecop.freeze do
      service.call

      expect(release.updated_at).to be_within(1.second).of Time.zone.now
    end
  end

  it "sets attributes" do
    service.call

    release.reload
    expect(release.name).to eq "releases.name"
    expect(release.description).to eq "releases.description"
    expect(release.released_at).to eq Date.new(2000, 1, 1)
  end

  it "sets musicbrainz_key" do
    service.call

    release.reload
    expect(release.musicbrainz_key).to eq "releases.musicbrainz_key"
  end

  it "does not set synced_at" do
    service.call

    release.reload
    expect(release.synced_at).to be_nil
  end

  context "when performing a full sync" do
    subject(:service) { described_class.new(release, full: true) }

    it "sets attributes" do
      service.call

      release.reload
      expect(release.name).to eq "releases.name"
      expect(release.description).to eq "releases.description"
      expect(release.released_at).to eq Date.new(2000, 1, 1)
    end

    it "sets synced_at" do
      Timecop.freeze do
        service.call

        release.reload
        expect(release.synced_at).to be_within(1.second).of Time.zone.now
      end
    end
  end
end
