# frozen_string_literal: true

RSpec.describe Graph::Release do
  it { is_expected.to define_property :name, :String }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to define_property :released_at, :DateTime }
  it { is_expected.to validate_presence_of :released_at }

  it { is_expected.to define_property :musicbrainz_key, :String }
  it { is_expected.to validate_presence_of(:musicbrainz_key).allow_nil }
  it { is_expected.to define_constraint :musicbrainz_key, :unique }

  it { is_expected.to define_property :metal_archives_key, :String }
  it { is_expected.to validate_presence_of(:metal_archives_key).allow_nil }
  it { is_expected.to define_constraint :metal_archives_key, :unique }

  it { is_expected.to track_creations }
  it { is_expected.to track_modifications }
end