# frozen_string_literal: true

RSpec.describe GroupGenre do
  it { is_expected.to belong_to :group }
  it { is_expected.to belong_to :genre }
end
