# frozen_string_literal: true

RSpec.describe Graph::Genre do
  it { is_expected.to define_property :name, :String }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to track_creations }
  it { is_expected.to track_modifications }

  describe "#description" do
    it "generates a description" do
      expect(described_class.new(name: "symphonic_power").description).to eq "Symphonic Power Metal"
    end
  end
end
