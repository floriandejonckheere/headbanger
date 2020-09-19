# frozen_string_literal: true

RSpec.describe ThemeBuilder, type: :builder do
  subject(:theme) { described_class.new(description: "Epic").call }

  it { is_expected.to have_attributes name: "epic", description: "Epic" }
end
