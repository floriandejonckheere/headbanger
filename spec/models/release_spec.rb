# frozen_string_literal: true

RSpec.describe Release do
  it { is_expected.to have_many(:artist_releases).dependent :destroy }
  it { is_expected.to have_many(:artists).through :artist_releases }

  it { is_expected.to have_many(:group_releases).dependent :destroy }
  it { is_expected.to have_many(:groups).through :group_releases }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :released_at }

  it { is_expected.to validate_presence_of(:musicbrainz_key).allow_nil }
  it { is_expected.to validate_presence_of(:metal_archives_key).allow_nil }
end
