# frozen_string_literal: true

RSpec.describe Genre do
  subject(:genre) { build(:genre) }

  it { is_expected.to have_many(:group_genres).dependent :destroy }
  it { is_expected.to have_many(:groups).through :group_genres }

  it { is_expected.to belong_to(:genre).optional }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }

  describe "#description" do
    it "generates a description" do
      expect(described_class.new(name: "symphonic_power").description).to eq "Symphonic Power Metal"
    end
  end
end
