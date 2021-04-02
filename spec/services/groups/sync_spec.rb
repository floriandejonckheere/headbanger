# frozen_string_literal: true

RSpec.describe Groups::Sync do
  subject(:service) { described_class.new(group, full: false) }

  let(:group) { create(:group, synced_at: nil) }

  before do
    source = dinja_mock!("groups.source", any_args)

    allow(source)
      .to receive(:musicbrainz_key)
      .and_return "groups.musicbrainz_key"

    allow(source)
      .to receive(:attributes)
      .and_return name: "groups.name", alt_names: ["groups.alt_names"], description: "groups.description"

    allow(source)
      .to receive(:genres)
      .and_return [build(:genre, name: "power")]

    allow(source)
      .to receive(:themes)
      .and_return [build(:theme, name: "groups.theme_one"), build(:theme, name: "groups.theme_two")]

    allow(source)
      .to receive(:artists)
      .and_return [build(:artist, name: "artists.name", alt_names: ["artists.alt_names"], description: "artists.description")]

    allow(source)
      .to receive(:releases)
      .and_return [build(:release, name: "releases.name", description: "releases.description")]
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

      expect(group.themes.count).to eq 2
      expect(group.themes.pluck(:name)).to match_array %w(groups.theme_one groups.theme_two)
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
