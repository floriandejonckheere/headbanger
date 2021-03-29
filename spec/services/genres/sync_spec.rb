# frozen_string_literal: true

RSpec.describe Genres::Sync do
  subject(:service) { described_class.new(genre) }

  let(:genre) { build(:genre) }

  it "matches genre to existing genre" do
    genre = build(:genre, name: "power")
    service = described_class.new(genre)

    expect(service.call).to eq genre
  end

  it "maps genre onto existing genre" do
    genre = build(:genre, name: "melodic_power")
    service = described_class.new(genre)

    expect(service.call).to eq Genre.find_by(name: "power")
  end

  it "raises when genre could not be matched" do
    genre = build(:genre, name: "oriental")
    service = described_class.new(genre)

    expect { service.call }.to raise_error ImportError
  end
end
