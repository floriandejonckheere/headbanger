# frozen_string_literal: true

RSpec.describe Graph::ThemeBuilder do
  subject(:theme) { described_class.new(description: "Epic").call }

  it { is_expected.to have_attributes name: "epic", description: "Epic" }

  it "maps name" do
    theme = described_class.new(description: "Sci-Fi").call

    expect(theme.name).to eq "sci_fi"
  end
end
