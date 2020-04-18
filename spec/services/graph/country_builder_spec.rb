# frozen_string_literal: true

RSpec.describe Graph::CountryBuilder do
  subject(:country) { described_class.new(code: "BE").call }

  it { is_expected.to have_attributes code: "BE" }
end
