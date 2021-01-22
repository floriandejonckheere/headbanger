# frozen_string_literal: true

RSpec.xdescribe GenreBuilder, type: :builder do
  subject(:genre) { described_class.new(description: "Power Metal").call }

  it { is_expected.to have_attributes name: "power" }

  describe "fusion genres" do
    it "maps existing genres" do
      expect(described_class.new(description: "Power Metal").model).to be_persisted
    end

    it "maps new genres with existing supergenres" do
      genre = described_class.new(description: "Death Metal with a little Power").call

      expect(genre.supergenres).to match_array [find_or_initialize_genre("death"), find_or_initialize_genre("power")]
    end
  end

  describe "new subgenres" do
    it "assigns new subgenres" do
      genre = described_class.new(description: "Melodic Power Metal").call

      expect(genre.supergenres).to match_array [find_or_initialize_genre("power")]
    end
  end
end
