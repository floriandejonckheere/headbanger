# frozen_string_literal: true

RSpec.describe Release do
  subject(:release) { build(:release) }

  it { is_expected.to have_many(:artist_releases).dependent :destroy }
  it { is_expected.to have_many(:artists).through :artist_releases }

  it { is_expected.to have_many(:group_releases).dependent :destroy }
  it { is_expected.to have_many(:groups).through :group_releases }

  it { is_expected.to have_many(:ratings).dependent :destroy }
  it { is_expected.to have_many(:users).through :ratings }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :released_at }
end
