# frozen_string_literal: true

RSpec.shared_examples "it is syncable" do |_model|
  describe ".synced/.expired" do
    it "returns synced and expired records" do
      synced = create(described_class.name.underscore.to_sym, synced_at: 10.seconds.ago)
      unsynced = create(described_class.name.underscore.to_sym, synced_at: nil)
      expired = create(described_class.name.underscore.to_sym, synced_at: 1.year.ago)

      expect(described_class.synced).to include synced
      expect(described_class.synced).not_to include unsynced, expired

      expect(described_class.expired).to include unsynced, expired
      expect(described_class.expired).not_to include synced
    end
  end

  describe "#sync!" do
    it "calls the sync service" do
      model = create(described_class.name.underscore)

      service = dinja_mock!("#{described_class.name.downcase.pluralize}.sync", model)

      allow(service).to receive(:call).and_return true

      model.sync!

      expect(service).to have_received(:call)
    end
  end

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
