# frozen_string_literal: true

RSpec.describe Releases::Source do
  subject(:source) { described_class.new(metal_archives_key: "metal_archives_key", musicbrainz_key: "musicbrainz_key") }

  let(:metal_archives) { Releases::MetalArchivesMock.new }
  let(:musicbrainz) { Releases::MusicBrainzMock.new }

  before do
    allow(Headbanger.container)
      .to receive(:resolve)
      .with("releases.metal_archives", any_args)
      .and_return metal_archives

    allow(Headbanger.container)
      .to receive(:resolve)
      .with("releases.musicbrainz", any_args)
      .and_return musicbrainz
  end

  it { is_expected.to have_attributes name: "Metal Archives Name" }
  it { is_expected.to have_attributes description: /2000/ }
  it { is_expected.to have_attributes released_at: Date.new(2000, 1, 1) }
end
