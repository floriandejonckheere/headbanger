# frozen_string_literal: true

RSpec.describe Artists::Sync do
  subject(:service) { described_class.new(artist, full: false) }

  let(:artist) { build(:artist, synced_at: nil) }

  before do
    source = dinja_mock!("artists.source", any_args)

    allow(source)
      .to receive(:musicbrainz_key)
      .and_return "artists.musicbrainz_key"

    allow(source)
      .to receive(:attributes)
      .and_return name: "artists.name", alt_names: ["artists.alt_names"], description: "artists.description"

    allow(source)
      .to receive(:groups)
      .and_return [build(:group, name: "groups.name", alt_names: ["groups.alt_names"], description: "groups.description")]
  end

  it "raises when no key is present" do
    artist = build(:artist, metal_archives_key: nil)
    service = described_class.new(artist)

    expect { service.call }.to raise_error ImportError
  end

  it "does nothing if artist was recently synchronized" do
    artist = build(:artist, synced_at: 10.seconds.ago)
    service = described_class.new(artist)

    Timecop.freeze do
      service.call

      expect(artist).not_to be_within(1.second).of Time.zone.now
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
  end
end
