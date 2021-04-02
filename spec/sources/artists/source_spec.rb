# frozen_string_literal: true

RSpec.describe Artists::Source do
  subject(:source) { described_class.new(metal_archives_key: "metal_archives_key", musicbrainz_key: "musicbrainz_key") }

  let(:metal_archives) { Artists::MetalArchivesMock.new }
  let(:musicbrainz) { Artists::MusicBrainzMock.new }

  before do
    allow(Headbanger.container)
      .to receive(:resolve)
      .with("artists.metal_archives", any_args)
      .and_return metal_archives

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("artists.musicbrainz", any_args)
      .and_return musicbrainz
  end

  it { is_expected.to have_attributes name: "Metal Archives Name" }
  it { is_expected.to have_attributes alt_names: ["Name, Metal Archives", "Name, MusicBrainz"] }
  it { is_expected.to have_attributes country: "BE" }
  it { is_expected.to have_attributes description: /Belgium/ }
  it { is_expected.to have_attributes born_on: Date.new(2000, 1, 1), died_on: nil }
  it { is_expected.to have_attributes gender: "male" }
  it { is_expected.to have_attributes groups: [], releases: [] }
end
