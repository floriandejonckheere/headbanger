# frozen_string_literal: true

RSpec.describe Graph::Group do
  it { is_expected.to define_property :name, :String }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to define_property :alt_names }
  it { is_expected.to validate_presence_of(:alt_names).allow_nil }

  it { is_expected.to define_property :description, :String }
  it { is_expected.to validate_presence_of :description }

  it { is_expected.to define_property :formed_at, :Date }
  it { is_expected.to validate_presence_of :formed_at }

  it { is_expected.to define_property :state, :String }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_inclusion_of(:state).in_array described_class::STATES }

  it { is_expected.to define_property :musicbrainz_key, :Integer }
  it { is_expected.to validate_presence_of(:musicbrainz_key).allow_nil }

  it { is_expected.to define_property :metal_archives_key, :Integer }
  it { is_expected.to validate_presence_of(:metal_archives_key).allow_nil }

  it { is_expected.to track_creations }
  it { is_expected.to track_modifications }
end
