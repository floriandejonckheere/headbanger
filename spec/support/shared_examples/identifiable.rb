# frozen_string_literal: true

RSpec.shared_examples "it is identifiable" do |_model|
  it { is_expected.to validate_uniqueness_of(:metal_archives_key).allow_nil }
  it { is_expected.to validate_uniqueness_of(:musicbrainz_key).allow_nil }
end
