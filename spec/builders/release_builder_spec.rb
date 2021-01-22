# frozen_string_literal: true

RSpec.xdescribe ReleaseBuilder, type: :builder do
  subject(:release) { described_class.new(metal_archives_key: "391528").call }

  it { is_expected.to have_attributes metal_archives_key: "391528" }

  it { is_expected.to have_attributes name: "Alquimia" }
  it { is_expected.to have_attributes released_at: a_kind_of(Date) }
end
