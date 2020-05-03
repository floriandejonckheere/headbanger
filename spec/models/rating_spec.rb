# frozen_string_literal: true

RSpec.describe Rating do
  subject(:rating) { build(:rating) }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :rateable }

  it { is_expected.to validate_presence_of :rating }
  it { is_expected.to validate_inclusion_of(:rating).in_array described_class::RATINGS }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to([:rateable_id, :rateable_type]).case_insensitive }
end
