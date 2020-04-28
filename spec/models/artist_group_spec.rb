# frozen_string_literal: true

RSpec.describe ArtistGroup do
  it { is_expected.to belong_to :artist }
  it { is_expected.to belong_to :group }
end
