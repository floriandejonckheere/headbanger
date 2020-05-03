# frozen_string_literal: true

RSpec.shared_examples_for "identifiable" do
  subject(:model) { build(described_class.name.underscore.to_sym) }

  it { is_expected.to validate_uniqueness_of(:metal_archives_key).allow_nil }
  it { is_expected.to validate_uniqueness_of(:metal_archives_key).allow_nil }
end
