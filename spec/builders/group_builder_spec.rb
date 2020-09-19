# frozen_string_literal: true

RSpec.describe GroupBuilder, type: :builder do
  subject(:group) { described_class.new(metal_archives_key: "3540361100").call }

  it { is_expected.to have_attributes metal_archives_key: "3540361100" }

  it { is_expected.to have_attributes name: "Alquimia", alt_names: [] }
  it { is_expected.to have_attributes description: a_kind_of(String) }
  it { is_expected.to have_attributes formed_at: a_kind_of(Date) }
  it { is_expected.to have_attributes status: "on_hold" }
  it { is_expected.to have_attributes country: "ES" }

  it { is_expected.to have_attributes releases: match_array([find_or_initialize_release("391528"), find_or_initialize_release("548366")]) }
  it { is_expected.to have_attributes themes: match_array([find_or_initialize_theme("epic"), find_or_initialize_theme("legends")]) }
  it { is_expected.to have_attributes genres: match_array([find_or_initialize_genre("melodic_power")]) }
end
