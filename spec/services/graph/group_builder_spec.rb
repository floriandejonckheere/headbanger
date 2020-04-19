# frozen_string_literal: true

RSpec.describe Graph::GroupBuilder do
  subject(:group) { described_class.new(metal_archives_key: 3_540_361_100).call }

  it { is_expected.to have_attributes metal_archives_key: 3_540_361_100 }

  it { is_expected.to have_attributes name: "Alquimia", alt_names: [] }
  it { is_expected.to have_attributes description: a_kind_of(String) }
  it { is_expected.to have_attributes formed_at: a_kind_of(Date) }
  it { is_expected.to have_attributes state: "on_hold" }

  it { is_expected.to have_attributes country: graph_country("ES") }

  it { is_expected.to have_attributes releases: match_array([graph_release(391_528), graph_release(548_366)]) }
  it { is_expected.to have_attributes themes: match_array([graph_theme("epic"), graph_theme("legends")]) }
  it { is_expected.to have_attributes genres: match_array([graph_genre("melodic_power")]) }
end
