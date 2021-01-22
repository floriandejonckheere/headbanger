# frozen_string_literal: true

RSpec.describe Artist do
  subject(:artist) { build(:artist) }

  it { is_expected.to have_many(:artist_groups).dependent :destroy }
  it { is_expected.to have_many(:groups).through :artist_groups }

  it { is_expected.to have_many(:artist_releases).dependent :destroy }
  it { is_expected.to have_many(:releases).through :artist_releases }

  it { is_expected.to have_many(:ratings).dependent :destroy }
  it { is_expected.to have_many(:users).through :ratings }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of(:alt_names).allow_nil }
  it { is_expected.to validate_inclusion_of(:country).in_array ISO3166::Country.codes }
  it { is_expected.to validate_presence_of :gender }
  it { is_expected.to validate_inclusion_of(:gender).in_array described_class::GENDERS }

  xdescribe "#sync!" do
    subject(:artist) { create(:artist, metal_archives_key: "60908", synced_at: 1.day.ago) }

    it "touches the synced_at timestamp" do
      Timecop.freeze do
        artist.sync!

        expect(artist.synced_at).to be_within(1.second).of DateTime.current
      end
    end

    it "syncs data" do
      expect(artist.name).not_to eq "Alberto Rionda"

      artist.sync!
      artist.reload

      expect(artist.name).to eq "Alberto Rionda"
    end
  end
end
