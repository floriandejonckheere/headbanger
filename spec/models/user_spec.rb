# frozen_string_literal: true

RSpec.describe User do
  it { is_expected.to have_many(:ratings).dependent :destroy }

  it { is_expected.to have_many(:rated_artists).through :ratings }
  it { is_expected.to have_many(:rated_groups).through :ratings }
  it { is_expected.to have_many(:rated_releases).through :ratings }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_inclusion_of(:country).in_array ISO3166::Country.codes }
end
