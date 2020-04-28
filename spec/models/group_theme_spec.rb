# frozen_string_literal: true

RSpec.describe GroupTheme do
  it { is_expected.to belong_to :group }
  it { is_expected.to belong_to :theme }
end
