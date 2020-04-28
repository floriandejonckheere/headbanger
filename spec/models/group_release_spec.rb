# frozen_string_literal: true

RSpec.describe GroupRelease do
  it { is_expected.to belong_to :group }
  it { is_expected.to belong_to :release }
end
