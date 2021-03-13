# frozen_string_literal: true

RSpec.xdescribe ArtistBuilder, type: :builder do
  subject(:artist) { described_class.new(metal_archives_key: "60908").call }

  it { is_expected.to have_attributes metal_archives_key: "60908" }

  it { is_expected.to have_attributes name: "Alberto Rionda", alt_names: [] }
  it { is_expected.to have_attributes description: a_kind_of(String) }
  it { is_expected.to have_attributes born_on: a_kind_of(Date), died_on: nil }
  it { is_expected.to have_attributes gender: "male" }
  it { is_expected.to have_attributes country: "ES" }

  it { is_expected.to have_attributes groups: match_array([find_or_initialize_group("3540361100"), find_or_initialize_group("5795")]) }
end
