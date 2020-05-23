# frozen_string_literal: true

RSpec.describe Schema do
  # Run rails graphql:dump if this test fails
  it "is up to date with stored definition" do
    current = described_class.to_definition
    stored = File.read(Rails.root.join("app/graphql/schema.graphql"))

    expect(current).to eq stored
  end

  # Run rails graphql:fragments if this test fails
  it "is up to date with stored fragment types" do
    current = described_class.to_fragment_types
    stored = File.read(Rails.root.join("web/src/fragmentTypes.json"))

    expect(current).to eq stored
  end
end
