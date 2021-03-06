# frozen_string_literal: true

RSpec.describe Artists::Sync do
  subject(:service) { described_class.new(artist, full: false) }

  let(:artist) { build(:artist, synced_at: nil) }

  before do
    allow(Headbanger.container)
      .to receive(:resolve)
      .and_call_original

    allow(Headbanger.container)
      .to receive(:resolve)
        .with("artists.source", any_args) { Artists::SourceMock.new }

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("groups.sync", any_args) do |_key, group, **_options|
        instance_double("groups.sync")
          .tap { |d| allow(d).to receive(:call).and_return group }
      end

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("releases.sync", any_args) do |_key, release, **_options|
        instance_double("releases.sync")
          .tap { |d| allow(d).to receive(:call).and_return release }
      end
  end

  it "raises when no key is present" do
    artist = build(:artist, metal_archives_key: nil)
    service = described_class.new(artist)

    expect { service.call }.to raise_error ImportError
  end

  it "does nothing if model was recently synchronized" do
    artist = build(:artist, updated_at: 10.seconds.ago, synced_at: 10.seconds.ago)
    service = described_class.new(artist)

    Timecop.freeze do
      service.call

      expect(artist.updated_at).not_to be_within(1.second).of Time.zone.now
    end
  end

  it "synchronizes model if force is true" do
    artist = build(:artist, updated_at: 10.seconds.ago, synced_at: 10.seconds.ago)
    service = described_class.new(artist, force: true)

    Timecop.freeze do
      service.call

      expect(artist.updated_at).to be_within(1.second).of Time.zone.now
    end
  end

  it "sets attributes" do
    service.call

    artist.reload
    expect(artist.name).to eq "artists.name"
    expect(artist.alt_names).to eq ["artists.alt_names"]
    expect(artist.description).to eq "artists.description"
  end

  it "sets musicbrainz_key" do
    service.call

    artist.reload
    expect(artist.musicbrainz_key).to eq "artists.musicbrainz_key"
  end

  it "does not set synced_at" do
    service.call

    artist.reload
    expect(artist.synced_at).to be_nil
  end

  context "when performing a full sync" do
    subject(:service) { described_class.new(artist, full: true) }

    it "sets attributes" do
      service.call

      artist.reload
      expect(artist.name).to eq "artists.name"
      expect(artist.alt_names).to eq ["artists.alt_names"]
      expect(artist.description).to eq "artists.description"
    end

    it "sets synced_at" do
      Timecop.freeze do
        service.call

        artist.reload
        expect(artist.synced_at).to be_within(1.second).of Time.zone.now
      end
    end

    it "associates groups" do
      service.call

      expect(artist.groups.count).to eq 1
      expect(artist.groups.first.name).to eq "groups.name"
    end

    it "associates releases" do
      service.call

      expect(artist.releases.count).to eq 1
      expect(artist.releases.first.name).to eq "releases.name"
    end
  end
end
