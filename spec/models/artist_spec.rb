# frozen_string_literal: true

RSpec.describe Artist do
  subject(:artist) { build(:artist) }

  it_behaves_like "it is identifiable"
  it_behaves_like "it is syncable"

  it { is_expected.to have_many(:artist_groups).dependent :destroy }
  it { is_expected.to have_many(:groups).through :artist_groups }

  it { is_expected.to have_many(:artist_releases).dependent :destroy }
  it { is_expected.to have_many(:releases).through :artist_releases }

  it { is_expected.to have_many(:ratings).dependent :destroy }
  it { is_expected.to have_many(:users).through :ratings }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of(:alt_names).allow_nil }
  it { is_expected.to validate_inclusion_of(:country).in_array ISO3166::Country.codes.sample(10) }
  it { is_expected.to validate_presence_of :gender }
  it { is_expected.to validate_inclusion_of(:gender).in_array described_class::GENDERS }

  it "has a default gender" do
    expect(described_class.new.gender).to eq "unknown"
  end
end
