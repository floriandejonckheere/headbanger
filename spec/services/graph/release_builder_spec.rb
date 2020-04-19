# frozen_string_literal: true

RSpec.describe Graph::ReleaseBuilder do
  subject(:release) { described_class.new(metal_archives_key: 391_528).call }

  it { is_expected.to have_attributes metal_archives_key: 391_528 }

  it { is_expected.to have_attributes name: "Alquimia" }
  it { is_expected.to have_attributes released_at: a_kind_of(Date) }
end
