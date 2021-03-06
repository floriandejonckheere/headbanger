# frozen_string_literal: true

RSpec.describe Group do
  subject(:group) { build(:group) }

  it_behaves_like "it is identifiable"
  it_behaves_like "it is syncable"

  it { is_expected.to have_many(:artist_groups).dependent :destroy }
  it { is_expected.to have_many(:artists).through :artist_groups }

  it { is_expected.to have_many(:group_releases).dependent :destroy }
  it { is_expected.to have_many(:releases).through :group_releases }

  it { is_expected.to have_many(:group_themes).dependent :destroy }
  it { is_expected.to have_many(:themes).through :group_themes }

  it { is_expected.to have_many(:group_genres).dependent :destroy }
  it { is_expected.to have_many(:genres).through :group_genres }

  it { is_expected.to have_many(:ratings).dependent :destroy }
  it { is_expected.to have_many(:users).through :ratings }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of(:alt_names).allow_nil }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_inclusion_of(:status).in_array described_class::STATUSES }

  it "has a default status" do
    expect(described_class.new.status).to eq "unknown"
  end
end
