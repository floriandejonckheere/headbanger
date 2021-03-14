# frozen_string_literal: true

RSpec.describe Artists::Sync do
  subject(:service) { described_class.new(artist) }

  let(:artist) { create(:artist, :expired) }

  before do
    source = dinja_mock!("artists.source", any_args)

    allow(source)
      .to receive(:musicbrainz_key)
      .and_return "musicbrainz_key"

    allow(source)
      .to receive(:attributes)
      .and_return name: "name", alt_names: ["alt_names"], description: "description"
  end

  it "does nothing if model was recently synchronized" do
    artist = build(:artist, synced_at: 1.second.ago)
    service = described_class.new(artist)

    service.call

    expect(artist).not_to be_persisted
  end

  it "raises when no key is present" do
    artist = build(:artist, metal_archives_key: nil)
    service = described_class.new(artist)

    expect { service.call }.to raise_error ImportError
  end

  it "sets musicbrainz_key" do
    service.call

    artist.reload
    expect(artist.musicbrainz_key).to eq "musicbrainz_key"
  end

  it "sets attributes" do
    service.call

    artist.reload
    expect(artist.name).to eq "name"
    expect(artist.alt_names).to eq ["alt_names"]
    expect(artist.description).to eq "description"
  end

  it "sets synced_at" do
    Timecop.freeze do
      service.call

      artist.reload
      expect(artist.synced_at).to be_within(1.second).of Time.zone.now
    end
  end
end
