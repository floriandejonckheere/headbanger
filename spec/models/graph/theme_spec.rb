# frozen_string_literal: true

RSpec.describe Graph::Theme do
  it { is_expected.to define_property :name, :String }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to track_creations }
  it { is_expected.to track_modifications }

  describe "#description" do
    it "generates a description" do
      expect(described_class.new(name: "epic_dragon_lore").description).to eq "Epic Dragon Lore"
    end
  end
end
