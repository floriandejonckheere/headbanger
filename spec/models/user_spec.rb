# frozen_string_literal: true

RSpec.describe User do
  subject(:user) { build(:user) }

  it { is_expected.to have_many(:ratings).dependent :destroy }

  it { is_expected.to have_many(:rated_artists).through :ratings }
  it { is_expected.to have_many(:rated_groups).through :ratings }
  it { is_expected.to have_many(:rated_releases).through :ratings }

  it { is_expected.to have_many(:recommendations).dependent :destroy }

  it { is_expected.to have_many(:recommended_artists).through :recommendations }
  it { is_expected.to have_many(:recommended_groups).through :recommendations }
  it { is_expected.to have_many(:recommended_releases).through :recommendations }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :country }

  it { is_expected.to validate_inclusion_of(:country).in_array ISO3166::Country.codes }
end
