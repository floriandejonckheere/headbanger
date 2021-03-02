# frozen_string_literal: true

RSpec.describe Steps::Type do
  subject(:step) { described_class.new("foo_type") }

  it "enhances the data with a type" do
    expect(step.run({ id: "foo" })).to eq id: "foo", type: "foo_type"
  end
end
