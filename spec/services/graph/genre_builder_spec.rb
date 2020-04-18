# frozen_string_literal: true

RSpec.describe Graph::GenreBuilder do
  subject(:genre) { described_class.new(name: "power").call }

  it { is_expected.to have_attributes name: "power" }
end
