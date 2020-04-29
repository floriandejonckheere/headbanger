# frozen_string_literal: true

RSpec.describe Group do
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
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :formed_at }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_inclusion_of(:status).in_array described_class::STATUSES }

  it { is_expected.to validate_presence_of(:musicbrainz_key).allow_nil }
  it { is_expected.to validate_presence_of(:metal_archives_key).allow_nil }
end
