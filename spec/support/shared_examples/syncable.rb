# frozen_string_literal: true

RSpec.shared_examples "it is syncable" do |_model|
  it { is_expected.to validate_presence_of :synced_at }
end
