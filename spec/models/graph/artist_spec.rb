# frozen_string_literal: true

RSpec.describe Graph::Artist do
  it { is_expected.to define_property :name, :String }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to define_property :alt_names }
  it { is_expected.to validate_presence_of(:alt_names).allow_blank }

  it { is_expected.to define_property :description, :String }
  it { is_expected.to validate_presence_of :description }

  it { is_expected.to define_property :born_at, :Date }
  it { is_expected.to validate_presence_of :born_at }

  it { is_expected.to define_property :died_at, :Date }

  it { is_expected.to define_property :gender, :String }
  it { is_expected.to validate_presence_of :gender }

  it { is_expected.to define_property :musicbrainz_key, :String }
  it { is_expected.to validate_presence_of(:musicbrainz_key).allow_nil }

  it { is_expected.to define_property :metal_archives_key, :String }
  it { is_expected.to validate_presence_of(:metal_archives_key).allow_nil }

  it { is_expected.to track_creations }
  it { is_expected.to track_modifications }
end
