# frozen_string_literal: true

RSpec.describe ArtistRelease do
  it { is_expected.to belong_to :artist }
  it { is_expected.to belong_to :release }
end
