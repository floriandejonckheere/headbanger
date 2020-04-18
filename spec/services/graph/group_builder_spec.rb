# frozen_string_literal: true

RSpec.describe Graph::GroupBuilder do
  subject(:group) { described_class.new(metal_archives_key: 3_540_361_100).call }

  it { is_expected.to have_attributes metal_archives_key: 3_540_361_100 }

  it { is_expected.to have_attributes name: "Alquimia", alt_names: [] }
  it { is_expected.to have_attributes description: a_kind_of(String) }
  it { is_expected.to have_attributes formed_at: a_kind_of(Date) }
  it { is_expected.to have_attributes state: "on_hold" }

  it { is_expected.to have_attributes country: graph_country("ES") }

  it { is_expected.to have_attributes genres: match_array([graph_genre("melodic_power")]) }
end
