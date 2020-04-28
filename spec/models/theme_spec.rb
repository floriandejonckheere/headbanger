# frozen_string_literal: true

RSpec.describe Theme do
  subject(:theme) { build(:theme) }

  it { is_expected.to have_many(:group_themes).dependent :destroy }
  it { is_expected.to have_many(:groups).through :group_themes }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }

  describe "#description" do
    it "generates a description" do
      expect(described_class.new(name: "epic_dragon_lore").description).to eq "Epic Dragon Lore"
    end
  end
end
