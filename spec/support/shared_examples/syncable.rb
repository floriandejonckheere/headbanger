# frozen_string_literal: true

RSpec.shared_examples "it is syncable" do |_model|
  it { is_expected.to validate_presence_of :synced_at }

  describe "#synced?/#expired?" do
    context "when it has not been synced" do
      before { subject.synced_at = nil }

      it { is_expected.not_to be_synced }
      it { is_expected.to be_expired }
    end

    context "when it was synced a long time ago" do
      before { subject.synced_at = 1.year.ago }

      it { is_expected.not_to be_synced }
      it { is_expected.to be_expired }
    end

    context "when it was synced recently" do
      before { subject.synced_at = 10.seconds.ago }

      it { is_expected.to be_synced }
      it { is_expected.not_to be_expired }
    end
  end
end
