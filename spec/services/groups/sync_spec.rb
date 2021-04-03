# frozen_string_literal: true

RSpec.describe Groups::Sync do
  subject(:service) { described_class.new(group, full: false) }

  let(:group) { create(:group, synced_at: nil) }

  before do
    allow(Headbanger.container)
      .to receive(:resolve)
      .and_call_original

    allow(Headbanger.container)
      .to receive(:resolve)
        .with("groups.source", any_args) { Groups::SourceMock.new }

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("artists.sync", any_args) do |_key, artist, **_options|
      instance_double("artists.sync")
        .tap { |d| allow(d).to receive(:call).and_return artist }
    end

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("releases.sync", any_args) do |_key, release, **_options|
      instance_double("releases.sync")
        .tap { |d| allow(d).to receive(:call).and_return release }
    end
  end

  it "raises when no key is present" do
    group = build(:group, metal_archives_key: nil)
    service = described_class.new(group)

    expect { service.call }.to raise_error ImportError
  end

  it "does nothing if model was recently synchronized" do
    group = build(:group, updated_at: 10.seconds.ago, synced_at: 10.seconds.ago)
    service = described_class.new(group)

    Timecop.freeze do
      service.call

      expect(group.updated_at).not_to be_within(1.second).of Time.zone.now
    end
  end

  it "synchronizes model if force is true" do
    group = build(:group, updated_at: 10.seconds.ago, synced_at: 10.seconds.ago)
    service = described_class.new(group, force: true)

    Timecop.freeze do
      service.call

      expect(group.updated_at).to be_within(1.second).of Time.zone.now
    end
  end

  it "sets attributes" do
    service.call

    group.reload
    expect(group.name).to eq "groups.name"
    expect(group.alt_names).to eq ["groups.alt_names"]
    expect(group.description).to eq "groups.description"
  end

  it "sets musicbrainz_key" do
    service.call

    group.reload
    expect(group.musicbrainz_key).to eq "groups.musicbrainz_key"
  end

  it "does not set synced_at" do
    service.call

    group.reload
    expect(group.synced_at).to be_nil
  end

  context "when performing a full sync" do
    subject(:service) { described_class.new(group, full: true) }

    it "sets attributes" do
      service.call

      group.reload
      expect(group.name).to eq "groups.name"
      expect(group.alt_names).to eq ["groups.alt_names"]
      expect(group.description).to eq "groups.description"
    end

    it "sets synced_at" do
      Timecop.freeze do
        service.call

        group.reload
        expect(group.synced_at).to be_within(1.second).of Time.zone.now
      end
    end

    it "associates genres" do
      service.call

      expect(group.genres.count).to eq 1
      expect(group.genres.first.name).to eq "power"
    end

    it "associates themes" do
      service.call

      expect(group.themes.count).to eq 1
      expect(group.themes.pluck(:name)).to match_array %w(groups.theme)
    end

    it "associates artists" do
      service.call

      expect(group.artists.count).to eq 1
      expect(group.artists.first.name).to eq "artists.name"
    end

    it "associates releases" do
      service.call

      expect(group.releases.count).to eq 1
      expect(group.releases.first.name).to eq "releases.name"
    end
  end
end
