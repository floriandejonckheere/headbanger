# frozen_string_literal: true

RSpec.describe Recommendation do
  subject(:recommendation) { build(:recommendation) }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :recommended }

  it { is_expected.to validate_presence_of :reason }
  it { is_expected.to validate_inclusion_of(:reason).in_array described_class::REASONS }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to([:recommended_id, :recommended_type]).case_insensitive }
end
