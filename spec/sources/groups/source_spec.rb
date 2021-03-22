# frozen_string_literal: true

RSpec.describe Groups::Source do
  subject(:source) { described_class.new(metal_archives_key: "metal_archives_key", musicbrainz_key: "musicbrainz_key") }

  let(:metal_archives) { Groups::MetalArchivesMock.new }
  let(:musicbrainz) { Groups::MusicBrainzMock.new }

  before do
    allow(Headbanger.container)
      .to receive(:resolve)
      .with("groups.metal_archives", any_args)
      .and_return metal_archives

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("groups.musicbrainz", any_args)
      .and_return musicbrainz
  end

  it { is_expected.to have_attributes name: "Metal Archives Name" }
  it { is_expected.to have_attributes alt_names: ["Name, Metal Archives", "Name, MusicBrainz"] }
  it { is_expected.to have_attributes country: "BE" }
  it { is_expected.to have_attributes description: /Belgium/ }
  it { is_expected.to have_attributes formed_on: Date.new(2000, 1, 1) }
  it { is_expected.to have_attributes status: "active" }
  it { is_expected.to have_attributes artists: [] }
end
