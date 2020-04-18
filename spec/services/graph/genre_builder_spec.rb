# frozen_string_literal: true

RSpec.describe Graph::GenreBuilder do
  subject(:genre) { described_class.new(name: "power").call }

  it { is_expected.to have_attributes name: "power" }

  describe "fusion genres" do
    it "maps existing genres" do
      expect(described_class.new(name: "power").model).to be_persisted
    end

    it "processes the name" do
      genre = described_class.new(name: "Death Metal with a little Power").call

      expect(genre.name).to eq "death_with_a_little_power"
    end

    it "maps new genres with existing supergenres" do
      genre = described_class.new(name: "Death Metal with a little Power").call

      expect(genre.supergenres).to match_array [graph_genre("death"), graph_genre("power")]
    end
  end

  describe "new subgenres" do
    it "processes the name" do
      genre = described_class.new(name: "Melodic Power Metal").call

      expect(genre.name).to eq "melodic_power"
    end

    it "assigns new subgenres" do
      genre = described_class.new(name: "Melodic Power Metal").call

      expect(genre.supergenres).to match_array [graph_genre("power")]
    end
  end
end
